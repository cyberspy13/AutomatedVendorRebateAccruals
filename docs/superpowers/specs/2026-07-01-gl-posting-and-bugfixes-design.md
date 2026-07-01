# Design: Vendor Rebate G/L Posting + Bug Fixes

Date: 2026-07-01

## Goal

Deliver Story 2 of the epic: at the moment a Purchase Invoice is posted, post the
accrued rebate value to the General Ledger (separating it from inventory cost), and
fix two defects discovered during code review.

## Scope

In scope:
- (a) Post accrued rebate to the G/L via `GenJnlPostLine` using the two setup accounts.
- (b1) Fix the `Entry No.` AutoIncrement defect on the Rebate Ledger insert.
- (b2) Fix the rebate calculation triggers (discounts) + rounding + remove debug code.

Out of scope (existing gaps, left unchanged):
- Enforcing the Vendor `Enable Auto-Rebates` flag in `CalculateRebate`.
- Typos in field/object names, DataClassification, permission-set gaps.
- Automated AL tests (no test app in this repo).

## 1. G/L Posting

Location: `codeunit 53001 NAVIPurchaseOrderAndInvoice.PostPurchaseDocument`,
invoked from the `OnAfterPostPurchaseDoc` subscriber (codeunit 53000).

For each posted `Purch. Inv. Line` of Type Item with `Accured Rebate Amount <> 0`:

1. Resolve the line's Item Category (via `Item.Get(No.)`).
2. Look up `NAVI_VendorRebateSetup` by (`Buy-from Vendor No.`, Item Category Code).
3. Write the Rebate Ledger entry (see §2).
4. If both setup G/L accounts are non-blank, build one balanced `Gen. Journal Line`
   and post it via the passed `GenJnlPostLine`:
   - `Account Type` = G/L Account, `Account No.` = `Accural G/L Account(Bal.Sheet)`
   - `Bal. Account Type` = G/L Account, `Bal. Account No.` = `Rebate Income G/L Account(P&L)`
   - `Amount` = `+Accured Rebate Amount` (positive ⇒ Dr Account / Cr Bal. Account
     ⇒ **Dr Accrual (BS) / Cr Rebate Income (P&L)**)
   - `Posting Date` = line Posting Date; `Document No.` = invoice `Document No.`
   - `Currency Code` = posted invoice header currency; `Source Code` = header Source Code
   - `Description` = descriptive label referencing vendor/item
   - `System-Created Entry` = true; `Gen. Posting Type` left blank (no VAT)

Behaviour decisions (confirmed with user):
- Direction: **Dr Accrual (BS) / Cr Income (P&L)**.
- Granularity: **one balanced G/L transaction per invoice item line**.
- Missing accounts: **skip G/L post, still write the Rebate Ledger entry** (non-blocking).

## 2. AutoIncrement Fix

`table 53001 NAVI_VendorRebateLedgerEntry."Entry No."` has `AutoIncrement = true`.
Remove the manual `FindLast()` / `NextEntryNo` numbering in the codeunit and let the
platform assign `Entry No.` on `Insert(true)`. Eliminates the redundant assignment and
the `FindLast`-based concurrency risk.

## 3. Calculation Triggers Fix

`tableextension 53003 NAVI_PurchaseLine`:
- Add `OnAfterValidate` → `CalculateRebate()` on `Line Discount %`, `Line Discount Amount`,
  and `Line Amount` (existing: `No.`, `Quantity`, `Direct Unit Cost`).
- Wrap the computed amount in `Round()` (currency precision).
- Remove the leftover `test: codeunit 90;` variable.

## Verification

Compile the extension (AL compiler) — no automated tests exist. Manual posting
verification recommended in a sandbox: post an invoice for a rebate-enabled
vendor/category and confirm G/L entries (Dr Accrual / Cr Income) plus a matching
Rebate Ledger entry.

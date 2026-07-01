codeunit 53001 NAVIPurchaseOrderAndInvoice
{
    procedure PostPurchaseDocument(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]; CommitIsSupressed: Boolean)
    var
        Lrec_VendRebateLedEntry: record NAVI_VendorRebateLedgerEntry;
        Lrec_VendorRebateSetup: record NAVI_VendorRebateSetup;
        Lrec_PstdPurchaseInvHeader: record "Purch. Inv. Header";
        Lrec_PstdPurchaseInvLine: record "Purch. Inv. Line";
        Lrec_Item: record Item;
        Lcode_ItemCatCode: Code[20];
    begin
        if PurchInvHdrNo = '' then exit;
        if not Lrec_PstdPurchaseInvHeader.Get(PurchInvHdrNo) then exit;

        Lrec_PstdPurchaseInvLine.SetRange("Document No.", Lrec_PstdPurchaseInvHeader."No.");
        Lrec_PstdPurchaseInvLine.SetRange(Type, Lrec_PstdPurchaseInvLine.Type::Item);
        if Lrec_PstdPurchaseInvLine.FindSet() then
            repeat
                if Lrec_PstdPurchaseInvLine."Accured Rebate Amount" <> 0 then begin
                    // Rebate Ledger entry (Entry No. is assigned by AutoIncrement on Insert)
                    Lrec_VendRebateLedEntry.Init();
                    Lrec_VendRebateLedEntry."Posting Date" := Lrec_PstdPurchaseInvLine."Posting Date";
                    Lrec_VendRebateLedEntry."Vendor No." := Lrec_PstdPurchaseInvLine."Buy-from Vendor No.";
                    Lrec_VendRebateLedEntry."Document No." := Lrec_PstdPurchaseInvLine."Document No.";
                    Lrec_VendRebateLedEntry."Item No." := Lrec_PstdPurchaseInvLine."No.";
                    Lrec_VendRebateLedEntry."Accured Amount" := Lrec_PstdPurchaseInvLine."Accured Rebate Amount";
                    Lrec_VendRebateLedEntry.Insert(true);

                    // G/L accrual posting (Dr Accrual/BS, Cr Rebate Income/P&L)
                    Clear(Lcode_ItemCatCode);
                    if Lrec_Item.Get(Lrec_PstdPurchaseInvLine."No.") then
                        Lcode_ItemCatCode := Lrec_Item."Item Category Code";

                    if Lrec_VendorRebateSetup.Get(Lrec_PstdPurchaseInvLine."Buy-from Vendor No.", Lcode_ItemCatCode) then
                        PostRebateToGL(GenJnlPostLine, Lrec_PstdPurchaseInvHeader, Lrec_PstdPurchaseInvLine, Lrec_VendorRebateSetup);
                end;
            until Lrec_PstdPurchaseInvLine.Next() = 0;
    end;

    local procedure PostRebateToGL(var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PstdPurchaseInvHeader: Record "Purch. Inv. Header"; PstdPurchaseInvLine: Record "Purch. Inv. Line"; VendorRebateSetup: Record NAVI_VendorRebateSetup)
    var
        GenJnlLine: Record "Gen. Journal Line";
        Ltxt_Description: Label 'Rebate accrual %1 %2', Comment = '%1 = Vendor No., %2 = Item No.';
    begin
        // Skip G/L posting when accounts are not configured; the ledger entry is still kept.
        if (VendorRebateSetup."Accural G/L Account(Bal.Sheet)" = '') or (VendorRebateSetup."Rebate Income G/L Account(P&L)" = '') then
            exit;

        GenJnlLine.Init();
        GenJnlLine."Posting Date" := PstdPurchaseInvLine."Posting Date";
        GenJnlLine."Document No." := PstdPurchaseInvLine."Document No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        GenJnlLine."Account No." := VendorRebateSetup."Accural G/L Account(Bal.Sheet)";
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := VendorRebateSetup."Rebate Income G/L Account(P&L)";
        GenJnlLine."Currency Code" := PstdPurchaseInvHeader."Currency Code";
        GenJnlLine.Validate(Amount, PstdPurchaseInvLine."Accured Rebate Amount");
        GenJnlLine."Source Code" := PstdPurchaseInvHeader."Source Code";
        GenJnlLine.Description := StrSubstNo(Ltxt_Description, PstdPurchaseInvLine."Buy-from Vendor No.", PstdPurchaseInvLine."No.");
        GenJnlLine."System-Created Entry" := true;

        GenJnlPostLine.Run(GenJnlLine);
    end;

}

codeunit 53001 NAVIPurchaseOrderAndInvoice
{
    procedure PostPurchaseDocument(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]; CommitIsSupressed: Boolean)
    var
        Lrec_VendRebateLedEntry: record NAVI_VendorRebateLedgerEntry;
        Lrec_PstdPurchaseInvHeader: record "Purch. Inv. Header";
        Lrec_PstdPurchaseInvLine: record "Purch. Inv. Line";
        NextEntryNo: Integer;
    begin
        if PurchInvHdrNo = '' then exit;
        if not Lrec_PstdPurchaseInvHeader.Get(PurchInvHdrNo) then exit;

        if Lrec_VendRebateLedEntry.FindLast() then
            NextEntryNo := Lrec_VendRebateLedEntry."Entry No."
        else
            NextEntryNo := 0;

        Lrec_PstdPurchaseInvLine.SetRange("Document No.", Lrec_PstdPurchaseInvHeader."No.");
        Lrec_PstdPurchaseInvLine.SetRange(Type, Lrec_PstdPurchaseInvLine.Type::Item);
        if Lrec_PstdPurchaseInvLine.FindSet() then begin
            repeat
                if Lrec_PstdPurchaseInvLine."Accured Rebate Amount" <> 0 then begin
                    NextEntryNo += 1;
                    Lrec_VendRebateLedEntry.Init();
                    Lrec_VendRebateLedEntry."Entry No." := NextEntryNo;
                    Lrec_VendRebateLedEntry."Posting Date" := Lrec_PstdPurchaseInvLine."Posting Date";
                    Lrec_VendRebateLedEntry."Vendor No." := Lrec_PstdPurchaseInvLine."Buy-from Vendor No.";
                    Lrec_VendRebateLedEntry."Document No." := Lrec_PstdPurchaseInvLine."Document No.";
                    Lrec_VendRebateLedEntry."Item No." := Lrec_PstdPurchaseInvLine."No.";
                    Lrec_VendRebateLedEntry."Accured Amount" := Lrec_PstdPurchaseInvLine."Accured Rebate Amount";
                    Lrec_VendRebateLedEntry.Insert(true);
                end;
            until Lrec_PstdPurchaseInvLine.Next() = 0;
        end;
    end;

}

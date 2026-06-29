tableextension 53001 NAVI_PstdPurchaseInvoice extends "Purch. Inv. Line"
{
    fields
    {
        field(53000; "Accured Rebate Amount"; Decimal)
        {
            Caption = 'Accured Rebate Amount';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum(NAVI_VendorRebateLedgerEntry."Accured Amount" where("Document No." = field("Document No."), "Item No." = field("No.")));
        }
    }
}

tableextension 53003 NAVI_PurchaseLine extends "Purchase Line"
{
    fields
    {
        field(53000; "Accured Rebate Amount"; Decimal)
        {
            Caption = 'Accured Rebate Amount';
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                Lrec_VendorRebateSetup: record NAVI_VendorRebateSetup;
                Ldec_RebateValue: Decimal;
                Lrec_PurchaseHeader: record "Purchase Header";
                Lrec_PurchaseLine: record "Purchase Line";
                Lrec_Item: record Item;
                Lrec_ItemCatCode: Code[20];
            begin
                //Lrec_PurchaseLine.SetRange("Document Type", Rec."Document Type");
                // Lrec_PurchaseLine.SetRange("Document No.", Rec."Document No.");
                // if Lrec_PurchaseLine.FindFirst() then begin
                //   repeat
                // Lrec_VendorRebateSetup.get(Lrec_PurchaseLine."Buy-from Vendor Name");
                Lrec_Item.Get(Rec."No.");
                Lrec_ItemCatCode := Lrec_Item."Item Category Code";
                Lrec_VendorRebateSetup.Get(Rec."Buy-from Vendor No.", Lrec_ItemCatCode);
                if Lrec_VendorRebateSetup.IsEmpty then
                    exit else
                    Ldec_RebateValue := (Rec."Line Amount" * Lrec_VendorRebateSetup."Rebate %") / 100;
                Rec."Accured Rebate Amount" := Ldec_RebateValue;
                // until Lrec_PurchaseLine.Next() = 0;
                // end;
            end;
        }
    }

}

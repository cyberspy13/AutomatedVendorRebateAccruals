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
            begin
                CalculateRebate();
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                CalculateRebate();
            end;
        }
        modify("Direct Unit Cost")
        {
            trigger OnAfterValidate()
            begin
                CalculateRebate();
            end;
        }
        modify("Line Discount %")
        {
            trigger OnAfterValidate()
            begin
                CalculateRebate();
            end;
        }
        modify("Line Discount Amount")
        {
            trigger OnAfterValidate()
            begin
                CalculateRebate();
            end;
        }
        modify("Line Amount")
        {
            trigger OnAfterValidate()
            begin
                CalculateRebate();
            end;
        }
    }
    local procedure CalculateRebate()
    var
        Lrec_VendorRebateSetup: record NAVI_VendorRebateSetup;
        Lrec_Item: record Item;
        Lrec_ItemCatCode: Code[20];
    begin
        if Rec.Type <> Rec.Type::Item then
            exit;

        if Lrec_Item.Get(Rec."No.") then
            Lrec_ItemCatCode := Lrec_Item."Item Category Code";

        if Lrec_VendorRebateSetup.Get(Rec."Buy-from Vendor No.", Lrec_ItemCatCode) then
        begin
            Rec."Accured Rebate Amount" := Round((Rec."Line Amount" * Lrec_VendorRebateSetup."Rebate %") / 100);
        end else begin
            Rec."Accured Rebate Amount" := 0;
        end;
    end;
}

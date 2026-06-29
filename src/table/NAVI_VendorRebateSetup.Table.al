table 53000 NAVI_VendorRebateSetup
{
    Caption = 'Vendor Rebate Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
            trigger OnValidate()
            var
                Lrec_Vend: record Vendor;
                Ltxt_AutoRebError: Label 'This Vendor does not have Auto-Rebates feature enabled';
            begin
                Lrec_Vend.get("Vendor No.");
                if Lrec_Vend."Enable Auto-Rebates" <> true then begin
                    Error(Ltxt_AutoRebError)
                end;
            end;
        }
        field(2; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(3; "Rebate %"; Decimal)
        {
            Caption = 'Rebate %';
        }
        field(4; "Accural G/L Account(Bal.Sheet)"; Code[20])
        {
            Caption = 'Accural G/L Account(Balance Sheet)';
            TableRelation = "G/L Account";
        }
        field(5; "Rebate Income G/L Account(P&L)"; Code[20])
        {
            Caption = 'Rebate Income G/L Account(P&L)';
            TableRelation = "G/L Account";
        }
    }
    keys
    {
        key(PK; "Vendor No.", "Item Category Code")
        {
            Clustered = true;
        }
    }
}

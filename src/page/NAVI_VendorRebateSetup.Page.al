page 53000 NAVI_VendorRebateSetup
{
    ApplicationArea = All;
    Caption = 'Vendor Rebate Setup';
    PageType = List;
    SourceTable = NAVI_VendorRebateSetup;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Please specify Vandor No.';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ToolTip = 'Please specify  Item Category Code';
                }
                field("Rebate %"; Rec."Rebate %")
                {
                    Tooltip = 'Please specify Rebate Percentage';
                }
                field("Accural G/L Account(Bal.Sheet)"; Rec."Accural G/L Account(Bal.Sheet)")
                {
                    Tooltip = 'Please specify Accurel account';
                }
                field("Rebate Income G/L Account(P&L)"; Rec."Rebate Income G/L Account(P&L)")
                {
                    ToolTip = 'Please specify Rebate Income Account';
                }
            }
        }
    }
}

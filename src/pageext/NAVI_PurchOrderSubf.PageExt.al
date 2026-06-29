pageextension 53004 "NAVI_PurchOrderSubf " extends "Purchase Order Subform"
{
    layout
    {
        addafter("Line Amount")
        {
            field("Accured Rebate Amount"; Rec."Accured Rebate Amount")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Accured Rebate Amount';
            }
        }
    }
}

pageextension 53003 "NAVI_PurchInvSubf " extends "Purch. Invoice Subform"
{
    layout
    {
        addafter("Line Amount")
        {
            field("Accured Rebate Amount"; Rec."Accured Rebate Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Accured Rebate Amount';
            }
        }
    }
}

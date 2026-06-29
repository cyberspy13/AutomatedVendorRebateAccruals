pageextension 53000 "NAVI_PostPurchInvSubf " extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Accured Rebate Amount"; Rec."Accured Rebate Amount")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Accured Rebate Amount';
            }
        }
    }
}

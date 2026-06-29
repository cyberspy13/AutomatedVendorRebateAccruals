pageextension 53001 NAVI_Vendor extends "Vendor Card"
{
    layout
    {
        addafter(General)
        {
            field("Enable Auto-Rebates"; Rec."Enable Auto-Rebates")
            {
                ApplicationArea = All;
                Importance = Standard;
            }
        }
    }
}

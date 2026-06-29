page 53001 NAVI_VendorRebateLedgerEntry
{
    ApplicationArea = All;
    Caption = 'Vendor Rebate Ledger Entry';
    PageType = List;
    SourceTable = NAVI_VendorRebateLedgerEntry;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Accured Amount"; Rec."Accured Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

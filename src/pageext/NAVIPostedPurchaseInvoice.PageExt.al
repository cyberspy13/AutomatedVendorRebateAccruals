pageextension 53002 "NAVI_PretedPurchaseInvoice " extends "Posted Purchase Invoice"
{
    actions
    {
        addlast(navigation)
        {
            action(RebateEntries)
            {
                Caption = 'Rebate Entries';
                ApplicationArea = All;
                Image = Entries;
                RunObject = PAGE NAVI_VendorRebateLedgerEntry;
                RunPageLink = "Vendor No." = field("No.");
            }
        }
    }

}

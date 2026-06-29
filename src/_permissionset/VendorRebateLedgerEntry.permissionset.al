namespace VendorRebateEntry;

permissionset 53000 VendorRebateLedger
{
    Assignable = true;
    Permissions = tabledata NAVI_VendorRebateLedgerEntry = RIMD,
        tabledata NAVI_VendorRebateSetup = RIMD,
        table NAVI_VendorRebateLedgerEntry = X,
        table NAVI_VendorRebateSetup = X,
        codeunit NAVI_EventSubscribers = X,
        page NAVI_VendorRebateLedgerEntry = X,
        page NAVI_VendorRebateSetup = X;
}
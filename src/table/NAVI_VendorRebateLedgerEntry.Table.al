table 53001 NAVI_VendorRebateLedgerEntry
{
    Caption = 'NAVI_VendorRebateLedgerEntry';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            Editable = false;
            Autoincrement = true;
        }
        field(2; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(3; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(6; "Accured Amount"; Decimal)
        {
            Caption = 'Accured Amount';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}

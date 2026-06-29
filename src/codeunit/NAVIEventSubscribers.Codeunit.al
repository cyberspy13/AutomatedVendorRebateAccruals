codeunit 53000 NAVI_EventSubscribers
{
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', false, false)]
    procedure func_OnAfterPostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]; CommitIsSupressed: Boolean)
    var
        Lcdu_PostPurchDocument: codeunit NAVIPurchaseOrderAndInvoice;
    begin
        Lcdu_PostPurchDocument.PostPurchaseDocument(PurchaseHeader, GenJnlPostLine, PurchRcpHdrNo, RetShptHdrNo, PurchInvHdrNo, PurchCrMemoHdrNo, CommitIsSupressed);
    end;

}

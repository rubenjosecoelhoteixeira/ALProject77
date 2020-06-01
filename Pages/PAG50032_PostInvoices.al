page 50032 PostInvoices
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Post Invoices';

    actions
    {
        area(Processing)
        {
            action(PostInvoices)
            {
                Caption = 'Post Invoices';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    StartSession(PostingSessionId, Codeunit::"Post Invoices");
                end;
            }
            action(CheckResults)
            {
                Caption = 'Check Results';
                ApplicationArea = All;

                trigger OnAction()
                var
                    SessionEvent: Record "Session Event";
                begin
                    if PostingSessionId = 0 then
                        Error('Session was not started');

                    SessionEvent.SetRange("User ID", UserId);
                    SessionEvent.SetRange("Session ID", PostingSessionId);
                    SessionEvent.SetRange("Event Type", SessionEvent."Event Type"::Logoff);
                    if SessionEvent.FindLast() then
                        Message(SessionEvent.Comment);
                end;
            }
        }
    }

    var
        PostingSessionId: Integer;
}
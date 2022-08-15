module ApplicationHelper
    require "protobuf/nats"

    class EmailAlert < ::Protobuf::Message
        required :string, :subject, 1
        required :string, :body, 2
        required :string, :recipient_email, 3
    end



    class Status < ::Protobuf::Message
        required :string, :status, 1
    end


    class AlertService < ::Protobuf::Rpc::Service
        rpc :send_alert, EmailAlert, Status
    end
end

import ballerinax/kafka;
import ballerina/io;
import ballerina/log;

kafka:ProducerConfiguration producerConfiguration = {
    bootstrapServers: "localhost:9092",

    clientId: "student-producer",
    acks: "all",
    retryCount: 3
};

kafka:ConsumerConfiguration consumerConfiguration = {

    bootstrapServers: "localhost:9092",

    groupId: "group-id",
    offsetReset: "earliest",

    topics: ["studentApplication", "studentProposal", "studentThesis"]

};

kafka:Consumer consumer = checkpanic new (consumerConfiguration);
kafka:Producer kafkaProducer = checkpanic new (producerConfiguration);

public function supervisor() returns error? {

    consumer();

    //select applicant
    string message = "Hello World, Ballerina";

    check kafkaProducer->sendProducerRecord({
                                topic: "supervisorApplicantSelection",
                                value: message.toBytes() });

    check kafkaProducer->flushRecords();

    //review proposal
    check kafkaProducer->sendProducerRecord({
                                topic: "supervisorProposalReview",
                                value: message.toBytes() });

    check kafkaProducer->flushRecords();

    //approve thesis
    check kafkaProducer->sendProducerRecord({
                                topic: "supervisorThesisApproval",
                                value: message.toBytes() });

    check kafkaProducer->flushRecords();

}


public function consumer() returns error? {

    kafka:ConsumerRecord[] records = check consumer->poll(1000);

    foreach var kafkaRecord in records {
        byte[] messageContent = kafkaRecord.value;
        string|error message = string:fromBytes(messageContent);

        if (message is string) {

            io:println("Received Message: ", message);

        } else {
            log:printError("Error occurred while converting message data",
                err = message);
        }
    }
}

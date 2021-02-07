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

    topics: ["studentProposalUpload", "supervisorThesisApproval", "hdcProposalResolution"]

};

kafka:Consumer consumer = checkpanic new (consumerConfiguration);
kafka:Producer kafkaProducer = checkpanic new (producerConfiguration);

public function hod() returns error? {

    consumer();

    //approve supervisor selection based their exprerience
    string message = "Hello World, Ballerina";

    check kafkaProducer->sendProducerRecord({
                                topic: "hodSupervisorSelectionApproval",
                                value: message.toBytes() });

    check kafkaProducer->flushRecords();

    //assign FIE to proposal
    check kafkaProducer->sendProducerRecord({
                                topic: "hodAssignFie",
                                value: message.toBytes() });

    check kafkaProducer->flushRecords();

    //assign FEE to thesis
    check kafkaProducer->sendProducerRecord({
                                topic: "hodAssignThesis",
                                value: message.toBytes() });

    check kafkaProducer->flushRecords();

    //change student status to final submission
    check kafkaProducer->sendProducerRecord({
                                topic: "hodFinalAdmission",
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

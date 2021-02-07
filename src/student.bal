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

    topics: ["supervisorPickStudent", "supervisorProposalReview", "hdcThesisEndorsement", "hodFinalAdmission", "hdcThesisEndorsement"]

};

kafka:Consumer consumer = checkpanic new (consumerConfiguration);
kafka:Producer kafkaProducer = checkpanic new (producerConfiguration);


public function student() returns error? {

    consumer();

    
    //Apply

    string message = "Hello World, Ballerina";

    check kafkaProducer->sendProducerRecord({
                                topic: "studentApplication",
                                value: message.toBytes() });

    check kafkaProducer->flushRecords();

   
   //Propose
    check kafkaProducer->sendProducerRecord({
                                topic: "studentProposal",
                                value: message.toBytes() });

    check kafkaProducer->flushRecords();


    //Upload proposal
    check kafkaProducer->sendProducerRecord({
                                topic: "studentProposalUpload",
                                value: message.toBytes() });

    check kafkaProducer->flushRecords();

    //Thesis
    check kafkaProducer->sendProducerRecord({
                                topic: "studentThesis",
                                value: message.toBytes() });

    check kafkaProducer->flushRecords();

}


public function consumer() returns error? {

    kafka:ConsumerRecord[] records = check consumer->poll(1000);

    foreach var kafkaRecord in records {
        string topic = kafkaRecord.topic;
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

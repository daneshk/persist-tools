// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

import ballerina/jballerina.java;
import ballerina/persist;
import ballerina/sql;
import ballerinax/h2.driver as _;
import ballerinax/java.jdbc;
import ballerinax/persist.sql as psql;

const APPOINTMENT = "appointments";
const PATIENT = "patients";
const DOCTOR = "doctors";

public isolated client class Client {
    *persist:AbstractPersistClient;

    private final jdbc:Client dbClient;

    private final map<psql:SQLClient> persistClients;

    private final record {|psql:SQLMetadata...;|} & readonly metadata = {
        [APPOINTMENT]: {
            entityName: "Appointment",
            tableName: "appointment",
            fieldMetadata: {
                id: {columnName: "id"},
                reason: {columnName: "reason"},
                appointmentTime: {columnName: "appointmentTime"},
                status: {columnName: "status"},
                patientId: {columnName: "patient_id"},
                doctorId: {columnName: "doctorId"},
                "patient.idP": {relation: {entityName: "patient", refField: "idP", refColumn: "IDP"}},
                "patient.name": {relation: {entityName: "patient", refField: "name"}},
                "patient.age": {relation: {entityName: "patient", refField: "age"}},
                "patient.address": {relation: {entityName: "patient", refField: "address", refColumn: "ADDRESS"}},
                "patient.phoneNumber": {relation: {entityName: "patient", refField: "phoneNumber"}},
                "patient.gender": {relation: {entityName: "patient", refField: "gender"}},
                "doctor.id": {relation: {entityName: "doctor", refField: "id"}},
                "doctor.name": {relation: {entityName: "doctor", refField: "name"}},
                "doctor.specialty": {relation: {entityName: "doctor", refField: "specialty"}},
                "doctor.phoneNumber": {relation: {entityName: "doctor", refField: "phoneNumber", refColumn: "phone_number"}},
                "doctor.salary": {relation: {entityName: "doctor", refField: "salary"}}
            },
            keyFields: ["id"],
            joinMetadata: {
                patient: {entity: Patient, fieldName: "patient", refTable: "patients", refColumns: ["IDP"], joinColumns: ["patient_id"], 'type: psql:ONE_TO_MANY},
                doctor: {entity: Doctor, fieldName: "doctor", refTable: "Doctor", refColumns: ["id"], joinColumns: ["doctorId"], 'type: psql:ONE_TO_MANY}
            }
        },
        [PATIENT]: {
            entityName: "Patient",
            tableName: "patients",
            fieldMetadata: {
                idP: {columnName: "IDP", dbGenerated: true},
                name: {columnName: "name"},
                age: {columnName: "age"},
                address: {columnName: "ADDRESS"},
                phoneNumber: {columnName: "phoneNumber"},
                gender: {columnName: "gender"},
                "appointments[].id": {relation: {entityName: "appointments", refField: "id"}},
                "appointments[].reason": {relation: {entityName: "appointments", refField: "reason"}},
                "appointments[].appointmentTime": {relation: {entityName: "appointments", refField: "appointmentTime"}},
                "appointments[].status": {relation: {entityName: "appointments", refField: "status"}},
                "appointments[].patientId": {relation: {entityName: "appointments", refField: "patientId", refColumn: "patient_id"}},
                "appointments[].doctorId": {relation: {entityName: "appointments", refField: "doctorId"}}
            },
            keyFields: ["idP"],
            joinMetadata: {appointments: {entity: Appointment, fieldName: "appointments", refTable: "appointment", refColumns: ["patient_id"], joinColumns: ["IDP"], 'type: psql:MANY_TO_ONE}}
        },
        [DOCTOR]: {
            entityName: "Doctor",
            tableName: "Doctor",
            fieldMetadata: {
                id: {columnName: "id"},
                name: {columnName: "name"},
                specialty: {columnName: "specialty"},
                phoneNumber: {columnName: "phone_number"},
                salary: {columnName: "salary"},
                "appointments[].id": {relation: {entityName: "appointments", refField: "id"}},
                "appointments[].reason": {relation: {entityName: "appointments", refField: "reason"}},
                "appointments[].appointmentTime": {relation: {entityName: "appointments", refField: "appointmentTime"}},
                "appointments[].status": {relation: {entityName: "appointments", refField: "status"}},
                "appointments[].patientId": {relation: {entityName: "appointments", refField: "patientId", refColumn: "patient_id"}},
                "appointments[].doctorId": {relation: {entityName: "appointments", refField: "doctorId"}}
            },
            keyFields: ["id"],
            joinMetadata: {appointments: {entity: Appointment, fieldName: "appointments", refTable: "appointment", refColumns: ["doctorId"], joinColumns: ["id"], 'type: psql:MANY_TO_ONE}}
        }
    };

    public isolated function init() returns persist:Error? {
        jdbc:Client|error dbClient = new (url = url, user = user, password = password, options = connectionOptions);
        if dbClient is error {
            return <persist:Error>error(dbClient.message());
        }
        self.dbClient = dbClient;
        self.persistClients = {
            [APPOINTMENT]: check new (dbClient, self.metadata.get(APPOINTMENT), psql:H2_SPECIFICS),
            [PATIENT]: check new (dbClient, self.metadata.get(PATIENT), psql:H2_SPECIFICS),
            [DOCTOR]: check new (dbClient, self.metadata.get(DOCTOR), psql:H2_SPECIFICS)
        };
    }

    isolated resource function get appointments(AppointmentTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor",
        name: "query"
    } external;

    isolated resource function get appointments/[int id](AppointmentTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor",
        name: "queryOne"
    } external;

    isolated resource function post appointments(AppointmentInsert[] data) returns int[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(APPOINTMENT);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from AppointmentInsert inserted in data
            select inserted.id;
    }

    isolated resource function put appointments/[int id](AppointmentUpdate value) returns Appointment|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(APPOINTMENT);
        }
        _ = check sqlClient.runUpdateQuery(id, value);
        return self->/appointments/[id].get();
    }

    isolated resource function delete appointments/[int id]() returns Appointment|persist:Error {
        Appointment result = check self->/appointments/[id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(APPOINTMENT);
        }
        _ = check sqlClient.runDeleteQuery(id);
        return result;
    }

    isolated resource function get patients(PatientTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor",
        name: "query"
    } external;

    isolated resource function get patients/[int idP](PatientTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor",
        name: "queryOne"
    } external;

    isolated resource function post patients(PatientInsert[] data) returns int[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(PATIENT);
        }
        sql:ExecutionResult[] result = check sqlClient.runBatchInsertQuery(data);
        return from sql:ExecutionResult inserted in result
            where inserted.lastInsertId != ()
            select <int>inserted.lastInsertId;
    }

    isolated resource function put patients/[int idP](PatientUpdate value) returns Patient|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(PATIENT);
        }
        _ = check sqlClient.runUpdateQuery(idP, value);
        return self->/patients/[idP].get();
    }

    isolated resource function delete patients/[int idP]() returns Patient|persist:Error {
        Patient result = check self->/patients/[idP].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(PATIENT);
        }
        _ = check sqlClient.runDeleteQuery(idP);
        return result;
    }

    isolated resource function get doctors(DoctorTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor",
        name: "query"
    } external;

    isolated resource function get doctors/[int id](DoctorTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor",
        name: "queryOne"
    } external;

    isolated resource function post doctors(DoctorInsert[] data) returns int[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(DOCTOR);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from DoctorInsert inserted in data
            select inserted.id;
    }

    isolated resource function put doctors/[int id](DoctorUpdate value) returns Doctor|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(DOCTOR);
        }
        _ = check sqlClient.runUpdateQuery(id, value);
        return self->/doctors/[id].get();
    }

    isolated resource function delete doctors/[int id]() returns Doctor|persist:Error {
        Doctor result = check self->/doctors/[id].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(DOCTOR);
        }
        _ = check sqlClient.runDeleteQuery(id);
        return result;
    }

    remote isolated function queryNativeSQL(sql:ParameterizedQuery sqlQuery, typedesc<record {}> rowType = <>) returns stream<rowType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor"
    } external;

    remote isolated function executeNativeSQL(sql:ParameterizedQuery sqlQuery) returns psql:ExecutionResult|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor"
    } external;

    public isolated function close() returns persist:Error? {
        error? result = self.dbClient.close();
        if result is error {
            return <persist:Error>error(result.message());
        }
        return result;
    }
}


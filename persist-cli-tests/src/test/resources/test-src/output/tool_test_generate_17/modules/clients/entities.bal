// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer.
// It should not be modified by hand.

import ballerina/persist;

@persist:Entity {
    key: ["id"],
    tableName: "Companies"
}
public type Company record {|
    readonly int id;
    string name;
    Employee[] employee?;
|};

@persist:Entity {
    key: ["id"],
    tableName: "Employees"
}
public type Employee record {|
    readonly int id;
    string name;

    @persist:Relation {keyColumns: ["companyId"], reference: ["id"]}
    Company company?;

    Vehicle[] vehicles?;
|};

@persist:Entity {
    key: ["model"],
    tableName: "Vehicles"
}
public type Vehicle record {|
    readonly int model;
    string name;

    @persist:Relation {keyColumns: ["employeeId"], reference: ["id"]}
    Employee employee?;
|};


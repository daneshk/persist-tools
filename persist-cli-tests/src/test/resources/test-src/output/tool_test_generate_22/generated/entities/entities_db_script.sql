DROP TABLE IF EXISTS MedicalNeed;
DROP TABLE IF EXISTS MedicalItem;

CREATE TABLE MedicalItem (
	itemId INT NOT NULL,
	string VARCHAR(191) NOT NULL,
	type VARCHAR(191) NOT NULL,
	unit VARCHAR(191) NOT NULL,
	PRIMARY KEY(itemId)
);

CREATE TABLE MedicalNeed (
	record INT NOT NULL,
	beneficiaryId INT NOT NULL,
	time DATETIME NOT NULL,
	urgency VARCHAR(191) NOT NULL,
	quantity INT NOT NULL,
	medicalitemItemId INT NOT NULL,
	CONSTRAINT FK_MEDICALNEED_MEDICALITEM FOREIGN KEY(medicalitemItemId) REFERENCES MedicalItem(itemId),
	PRIMARY KEY(record)
);

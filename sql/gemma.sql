-- Gemma's database schema for Elephant SQL
-- Gemma is Team D's CS262 project at Calvin University.
-- @authors: Braden Weber, Becca DiCosola, Grace Jung, Eleanor Lee, Oscar Schott
--
-- Fall 2021

-- Drop previous versions of the tables if they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS "Pin" CASCADE;
DROP TABLE IF EXISTS "Board" CASCADE;
DROP TABLE IF EXISTS "AUser" CASCADE;
-- Create User, Board, and Pin tables.
CREATE TABLE "AUser" (
    userID int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    emailAddress varchar(100) NOT NULL,
    passphrase varchar(100) NOT NULL,
    nickname varchar(100),
    photo varchar(100) -- user will be able to pick one of several files within app
);
CREATE TABLE "Board" (
    boardID int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    boardName varchar(50),
    boardType varchar(3), -- PUB or PRI
    boardMap varchar(3), -- ECO or CAM
    userID int NOT NULL,
    CONSTRAINT fk_board
      FOREIGN KEY(userID) REFERENCES "AUser"(userID)
);
CREATE TABLE "Pin" (
    boardID int,
    pinid int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pinName varchar(100),
    pinNotes varchar(500),
    pinTag varchar(100),
    longitude decimal (17,14) NOT NULL,
    latitude decimal (17,14)  NOT NULL, 
    CONSTRAINT fk_pin
        FOREIGN KEY(boardID) REFERENCES "Board"(boardID)
);

-- Allow users to select data from the tables.
-- Quotes allow ElephantSQL to recognize capitalization of table names.
GRANT SELECT ON "AUser" TO PUBLIC;
GRANT SELECT ON "Pin" TO PUBLIC;
GRANT SELECT ON "Board" TO PUBLIC;

-- Add sample records.
INSERT INTO "AUser"(emailAddress, passphrase, nickname, photo) VALUES ('yj225@students.calvin.edu', 'GemmaDemo0', 'Grace', '../assets/defaultAvatar.png');
INSERT INTO "AUser"(emailAddress, passphrase) VALUES ('ehl6@students.calvin.edu', 'GemmaDemo0');
INSERT INTO "AUser"(emailAddress, passphrase, nickname, photo) VALUES ('rmd34@students.calvin.edu', 'GemmaDemo0', 'Becca', 'defaultAvatar');
INSERT INTO "AUser"(emailAddress, passphrase) VALUES ('blw22@students.calvin.edu', 'GemmaDemo0');
INSERT INTO "AUser"(emailAddress, passphrase) VALUES ('ots3@students.calvin.edu', 'GemmaDemo0');

INSERT INTO "Board"(boardName, boardType, boardMap, userID) VALUES ('Default Private', 'PRI', 'ECO', 3);
INSERT INTO "Board"(boardName, boardType, boardMap, userID) VALUES ('Public', 'PUB', 'CAM', 3);

INSERT INTO "Pin" VALUES (1, 0, 'The middle of the map', 'this pin is in the middle of the map!', '', -85.5795755, 42.934196);
INSERT INTO "Pin" VALUES (2, 1, 'The almost middle of the map', 'this pin is around the middle of the map!', '', -85.586404, 42.932402);


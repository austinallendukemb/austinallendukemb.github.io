



































































































CREATE TABLE Lesson (
  Name VARCHAR(64),
  Instructor_OID INTEGER NOT NULL
      -- foreign key constraint can be part of column definition
      REFERENCES Instructor (Instructor_OID),
  PRIMARY KEY (Name, Instructor_OID)
);





CREATE TABLE Lesson (
  Name VARCHAR(64) NOT NULL,
  Instructor_OID INTEGER NOT NULL
  -- foreign key constraint can be defined separately
  FOREIGN KEY (Instructor_OID)
      REFERENCES Instructor (Instructor_OID)
  PRIMARY KEY (Name, Instructor_OID)
);





CREATE TABLE Lesson (
  Name VARCHAR(64),
  Instructor_OID INTEGER NOT NULL
      -- foreign key constraint can be part of column definition
      REFERENCES Instructor (Instructor_OID)
      ON DELETE RESTRICT,
  PRIMARY KEY (Name, Instructor_OID)
);





CREATE TABLE Lesson (
  Name VARCHAR(64),
  Instructor_OID INTEGER NOT NULL
      -- foreign key constraint can be part of column definition
      REFERENCES Instructor (Instructor_OID)
      ON DELETE RESTRICT,
  PRIMARY KEY (Name, Instructor_OID)
);
```






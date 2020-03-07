CREATE TABLE b00074902.Person_Role
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Name varchar(20) NOT NULL
);

-------------------------------------------------------

CREATE TABLE b00074902.Person
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Username VARCHAR(255) NOT NULL UNIQUE,
    Password_Hash VARCHAR(255) NOT NULL,
    Password_Salt VARCHAR(255) NOT NULL,
    Last_Login_Time TIMESTAMP NOT NULL
);

-------------------------------------------------------

CREATE TABLE b00074902.Map_Person_Role
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Person_Id int NOT NULL,
    Role_Id int NOT NULL,
    CONSTRAINT fk_MapPersonRole_PersonId FOREIGN KEY(Person_Id) REFERENCES b00074902.Person(Id),
    CONSTRAINT fk_MapPersonRole_RoleId FOREIGN KEY(Role_Id) REFERENCES b00074902.Person_Role(Id)
);

-------------------------------------------------------

CREATE TABLE b00074902.Meal_Type
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Name varchar(20)
        NOT NULL
);

-------------------------------------------------------

CREATE TABLE b00074902.Allergen
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Name varchar(20)
        NOT NULL
);

-------------------------------------------------------

CREATE TABLE b00074902.Cuisine
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Name varchar(20)
        NOT NULL
);

-------------------------------------------------------

CREATE TABLE b00074902.Spice_Level
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Name varchar(20)
        NOT NULL
);

-------------------------------------------------------

CREATE TABLE b00074902.Donee_Type
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Name varchar(20) NOT NULL
);

-------------------------------------------------------

CREATE TABLE b00074902.Donee_Status
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Name varchar(20) NOT NULL, 
    Has_Access CHAR(1) NOT NULL CHECK (Has_Access IN ('Y','N'))
);
-------------------------------------------------------

CREATE TABLE b00074902.Donee
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Donee_Name VARCHAR(255) NOT NULL,
    Phone_Number VARCHAR(20) NOT NULL,
    Email VARCHAR(255) NOT NULL CHECK(REGEXP_LIKE (EMAIL,'^[A-Za-z]+[A-Za-z0-9.]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$')),
    Address_Description VARCHAR(255) NOT NULL,
    City VARCHAR(255) NOT NULL,
    Country VARCHAR(255) NOT NULL,
    Donee_Status_Id int NOT NULL,
    Donee_Type_Id int NOT NULL,
    Member_Count int NOT NULL check (0 < Member_Count),
    Quantity_Requested int NOT NULL check (0 <= Quantity_Requested),
    Person_Id int NOT NULL UNIQUE,
    CONSTRAINT fk_Donee_StatusId FOREIGN KEY(Donee_Status_Id) REFERENCES b00074902.Donee_Status(Id),
    CONSTRAINT fk_Donee_TypeId FOREIGN KEY(Donee_Type_Id) REFERENCES b00074902.Donee_Type(Id),
    CONSTRAINT fk_Donee_PersonId FOREIGN KEY(Person_Id) REFERENCES b00074902.Person(Id)
);

-------------------------------------------------------

CREATE TABLE b00074902.Donee_Price_Range
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Donee_Id int NOT NULL UNIQUE,
    Start_Price int NOT NULL check(0 <= Start_Price),
    End_Price int NOT NULL,
    CONSTRAINT ck_DoneePriceRange_RangeCheck check(Start_Price <= End_Price),
    CONSTRAINT fk_DoneePriceRange_DoneeId FOREIGN KEY(Donee_Id) REFERENCES b00074902.Donee(Id)
);

-------------------------------------------------------

CREATE TABLE b00074902.Donee_Spice_Range
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Donee_Id int NOT NULL UNIQUE,
    Start_Level int NOT NULL check(0 <= Start_Level),
    End_Level int NOT NULL,
    CONSTRAINT ck_DoneeSpiceRange_RangeCheck check(Start_Level <= End_Level),
    CONSTRAINT fk_DoneeSpiceRange_DoneeId FOREIGN KEY(Donee_Id) REFERENCES b00074902.Donee(Id),
    CONSTRAINT fk_Food_StartLevel FOREIGN KEY(Start_Level) REFERENCES b00074902.Spice_Level(Id),
    CONSTRAINT fk_Food_EndLevel FOREIGN KEY(End_Level) REFERENCES b00074902.Spice_Level(Id)
);

-------------------------------------------------------

CREATE TABLE b00074902.Map_Donee_Allergen
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Donee_Id int NOT NULL,
    Allergen_Id int NOT NULL,
    CONSTRAINT fk_MapDoneeAllergen_DoneeId FOREIGN KEY(Donee_Id) REFERENCES b00074902.Donee(Id),
    CONSTRAINT fk_MapDoneeAllergen_AllergenId FOREIGN KEY(Allergen_Id) REFERENCES b00074902.Allergen(Id)
);

-------------------------------------------------------

CREATE TABLE b00074902.Map_Donee_Cuisine
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Donee_Id int NOT NULL,
    Cuisine_Id int NOT NULL,
    CONSTRAINT fk_MapDoneeCuisine_DoneeId FOREIGN KEY(Donee_Id) REFERENCES b00074902.Donee(Id),
    CONSTRAINT fk_MapDoneeCuisine_CuisineId FOREIGN KEY(Cuisine_Id) REFERENCES b00074902.Cuisine(Id)
);

-------------------------------------------------------

CREATE TABLE b00074902.Map_Donee_Meal_Type
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Donee_Id int NOT NULL,
    Meal_Type_Id int NOT NULL,
    CONSTRAINT fk_MapDoneeMealType_DoneeId FOREIGN KEY(Donee_Id) REFERENCES b00074902.Donee(Id),
    CONSTRAINT fk_MapDoneeMealType_MealTypeId FOREIGN KEY(Meal_Type_Id) REFERENCES b00074902.Meal_Type(Id)
);

-------------------------------------------------------

CREATE TABLE b00074902.Donor_Status
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Name varchar(20) NOT NULL,
    Has_Access CHAR(1) NOT NULL CHECK (Has_Access IN ('Y','N'))
);

-------------------------------------------------------

CREATE TABLE b00074902.Donor
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Donor_Name VARCHAR(255) NOT NULL,
    Phone_Number VARCHAR(20) NOT NULL,
    Email VARCHAR(255) NOT NULL CHECK(REGEXP_LIKE (EMAIL,'^[A-Za-z]+[A-Za-z0-9.]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$')),
    Address_Description VARCHAR(255) NOT NULL,
    City VARCHAR(255) NOT NULL,
    Country VARCHAR(255) NOT NULL,
    Rating int NOT NULL,
    Number_Of_Rating int NOT NULL check (0 <= Number_Of_Rating),
    Donor_Status_Id int NOT NULL,
    Person_Id int NOT NULL UNIQUE,
    CONSTRAINT fk_Donor_StatusId FOREIGN KEY(Donor_Status_Id) REFERENCES b00074902.Donor_Status(Id),
    CONSTRAINT fk_Donor_PersonId FOREIGN KEY(Person_Id) REFERENCES b00074902.Person(Id)
);

-------------------------------------------------------

CREATE TABLE b00074902.Food
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Food_Name varchar(20) NOT NULL,
    Description_Text varchar(255) NOT NULL,
    Price int NOT NULL check (0 <= Price),
    Meal_For_N_People number(5,2) NOT  NULL check (0 < Meal_For_N_People and Meal_For_N_People < 999),
    Quantity_Available int NOT NULL check (0 <= Quantity_Available),
    Spice_Level int NOT NULL,
    Donor_Id int NOT NULL,
    CONSTRAINT fk_Food_DonorId FOREIGN KEY(Donor_Id) REFERENCES b00074902.Donor(Id),
    CONSTRAINT fk_Food_SpiceLevel FOREIGN KEY(Spice_Level) REFERENCES b00074902.Spice_Level(Id)
);

-------------------------------------------------------

CREATE TABLE b00074902.Map_Food_Allergen
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Food_Id int NOT NULL,
    Allergen_Id int NOT NULL,
    CONSTRAINT fk_MapFoodAllergen_FoodId FOREIGN KEY(Food_Id) REFERENCES b00074902.Food(Id),
    CONSTRAINT fk_MapFoodAllergen_AllergenId FOREIGN KEY(Allergen_Id) REFERENCES b00074902.Allergen(Id)
);

-------------------------------------------------------

CREATE TABLE b00074902.Map_Food_Cuisine
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Food_Id int NOT NULL,
    Cuisine_Id int NOT NULL,
    CONSTRAINT fk_MapFoodCuisine_FoodId FOREIGN KEY(Food_Id) REFERENCES b00074902.Food(Id),
    CONSTRAINT fk_MapFoodCuisine_CuisineId FOREIGN KEY(Cuisine_Id) REFERENCES b00074902.Cuisine(Id)
);

-------------------------------------------------------

CREATE TABLE b00074902.Map_Food_Meal_Type
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Food_Id int NOT NULL,
    Meal_Type_Id int NOT NULL,
    CONSTRAINT uk_MapFoodMealType UNIQUE(Food_Id, Meal_Type_Id),
    CONSTRAINT fk_MapFoodMealType_FoodId FOREIGN KEY(Food_Id) REFERENCES b00074902.Food(Id),
    CONSTRAINT fk_MapFoodMealType_MealTypeId FOREIGN KEY(Meal_Type_Id) REFERENCES b00074902.Meal_Type(Id)
);

-------------------------------------------------------

CREATE TABLE b00074902.Request
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Donor_Id int NOT NULL,
    Donee_Id int NOT NULL,
    Final_Price int not NULL check (0 <= Final_Price),
    Discount_Applied int not NULL check (0 <= Discount_Applied),
    Request_Time TIMESTAMP NOT NULL,
    Is_Active CHAR(1) NOT NULL CHECK (Is_Active IN ('Y','N')),
    CONSTRAINT fk_Request_DonorId FOREIGN KEY(Donor_Id) REFERENCES b00074902.Donor(Id),
    CONSTRAINT fk_Request_DoneeId FOREIGN KEY(Donee_Id) REFERENCES b00074902.Donee(Id)
);

-------------------------------------------------------

CREATE TABLE b00074902.SUB_REQUEST
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Request_Id int NOT NULL,
    Food_Id int NOT NULL,
    Quantity int NOT NULL check (0 < Quantity),
    Price_At_Purchase int not NULL check (0 <= Price_At_Purchase),
    CONSTRAINT uk_SubRequest_RequestFood UNIQUE(Request_Id, Food_Id),
    CONSTRAINT fk_SubRequest_RequestId FOREIGN KEY(Request_Id) REFERENCES b00074902.Request(Id),
    CONSTRAINT fk_SubRequest_FoodId FOREIGN KEY(Food_Id) REFERENCES b00074902.Food(Id)
);

-------------------------------------------------------

CREATE TABLE b00074902.Complaint
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Request_Id int NOT NULL,
    Description_Text varchar(255) NOT NULL,
    Complaint_Time TIMESTAMP NOT NULL,
    From_Donee CHAR(1) NOT NULL CHECK (From_Donee IN ('Y','N')),
    Is_Active CHAR(1) NOT NULL CHECK (Is_Active IN ('Y','N')),
    CONSTRAINT uk_Complaint UNIQUE(Request_Id, From_Donee),
    CONSTRAINT fk_Complaint_OrderId FOREIGN KEY(Request_Id) REFERENCES b00074902.Request(Id)
);

-------------------------------------------------------

CREATE TABLE b00074902.Error_Log
(
    Id int GENERATED BY DEFAULT AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    Description_Text varchar(255) NOT NULL,
    Error_Time TIMESTAMP NOT NULL
);

-------------------------------------------------------
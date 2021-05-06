
DROP VIEW IF EXISTS MembershipExpireDate;
DROP VIEW IF EXISTS CurriculumSize;
DROP VIEW IF EXISTS CoachEvaluation;
DROP VIEW IF EXISTS IncomeMembership;

DROP FUNCTION IF EXISTS CheckWorkLoad;
DROP FUNCTION IF EXISTS CheckUsageTime;
DROP FUNCTION IF EXISTS CheckMembershipExpired;

DROP FUNCTION IF EXISTS TotalConsumptionOnCourse;
DROP FUNCTION IF EXISTS BMRCal;

DROP TABLE MemberCoachCurriculum;
DROP TABLE CommodityBought;
DROP TABLE Equipment;
DROP TABLE Membership;
DROP TABLE Member;
DROP TABLE Flow;
DROP TABLE MemberPhysicalCondition;
DROP TABLE DietPlan;
DROP TABLE Curriculum;
DROP TABLE Commodity;
DROP TABLE AnonymousEvaluationSystem;
DROP TABLE Staff;
DROP TABLE Gym;
DROP TABLE MembershipType;


-----------------------------------------------------------------------

CREATE DATABASE GROUP12_PROJ;
USE GROUP12_PROJ;

CREATE TABLE MembershipType
(MembershipTypeID VARCHAR(10) PRIMARY KEY,
 TypeName VARCHAR(30),
 MembershipFee MONEY NOT NULL
 );
INSERT INTO MembershipType
(MembershipTypeID, TypeName, MembershipFee) VALUES
('1', 'Day', 30),
('2', 'Week', 200),
('3', 'Month', 750),
('4', 'OneSeason', 2240),
('5', 'HalfYear', 4480),
('6', 'Year', 8888),
('7', 'TwoYear', 15000),
('8', 'Lifetime', 50000);
SELECT * FROM MembershipType;


CREATE TABLE Gym
(GymID VARCHAR(10) PRIMARY KEY,
 State VARCHAR(50) NOT NULL,
 City VARCHAR(50) NOT NULL,
 Street VARCHAR(50) NOT NULL
);
INSERT INTO Gym
(GymID, State, City, Street) VALUES
('01', 'Florida', 'FORT LAUDERDALE', '1751 Post Farm Road'),
('02', 'Texas', 'Livingston', '732 Woodrow Way'),
('03', 'New York', 'Albany', '3327 Golden Ridge Road'),
('04', 'Indiana', 'Waterloo', '2003 Pearcy Avenue'),
('05', 'Massachusetts', 'Boston', '3931 Valley View Drive'),
('06', 'Michigan', 'Lansing', '1270 Amethyst Drive'),
('07', 'New Jersey', 'Camden', '4263 Lake Road'),
('08', 'Indiana', 'PIERCEVILLE', '4851 Tator Patch Road'),
('09', 'Oregon', 'PHOENIX', '3661 Morgan Street'),
('10', 'Missouri', 'GREEN CASTLE', '1488 Maloy Court');
SELECT * FROM Gym;


CREATE TABLE Staff
(StaffID VARCHAR(10) PRIMARY KEY,
 GymID VARCHAR(10) REFERENCES Gym(GymID),
 FirstName VARCHAR(50) NOT NULL,
 LastName VARCHAR(50) NOT NULL,
 Gender VARCHAR(5) CHECK(Gender in ('M', 'F')) NOT NULL,
 BirthDate DATE,
 Age AS DATEDIFF(hour,BirthDate,GETDATE())/8766,
 Position VARCHAR(50) NOT NULL,
 Salary_Month MONEY NOT NULL
);
INSERT INTO Staff
(StaffID, GymID, FirstName, LastName, Gender, BirthDate, Position, Salary_Month) VALUES
('001', '01', 'Gladys', 'James', 'F', '1984-10-04', 'Coach', 6000),
('002', '01', 'Leonia', 'Hill', 'F', '1999-04-21', 'Coach', 4000),
('003', '01', 'Pamela', 'Seals', 'F', '1990-03-07', 'Coach', 2000),
('004', '01', 'Theresa', 'Chavez', 'F', '1990-09-12', 'Coach', 6000),
('005', '01', 'Eugene', 'Phillips', 'M', '1995-05-22', 'Coach', 5000),
('006', '01', 'Heather', 'Montgomery', 'F', '1994-05-09', 'Coach', 3800),
('007', '01', 'Robert', 'Lyles', 'M', '1970-02-05', 'Manager', 8400),
('008', '02', 'Tammy', 'Bailey', 'F', '1997-07-07', 'Coach', 3200),
('009', '02', 'Edward', 'Nelms', 'M', '1989-01-04', 'Coach', 2600),
('010', '02', 'Rachael', 'Coronel', 'F', '1970-12-26', 'Coach', 6800),
('011', '02', 'Harold', 'Menzel', 'M', '1999-10-11', 'Coach', 4400),
('012', '02', 'Elizabeth', 'Gill', 'F', '1988-12-03', 'Coach', 4000),
('013', '02', 'Julie', 'Abramowitz', 'F', '1978-09-06', 'Manager', 8400),
('014', '02', 'Scott', 'Grant', 'M', '1993-04-09', 'Coach', 5800),
('015', '03', 'Shawn', 'Tull', 'M', '1987-02-18', 'Coach', 4400),
('016', '03', 'Katherine', 'Shelley', 'F', '1983-03-30', 'Coach', 8300),
('017', '03', 'Ammie', 'Jones', 'F', '1992-09-21', 'Coach', 6250),
('018', '03', 'Leslie', 'Sealey', 'M', '1994-04-20', 'Coach', 5400),
('019', '03', 'Sandra', 'Pendleton', 'F', '1984-11-15', 'Manager', 9000),
('020', '03', 'Phyllis', 'Ferguson', 'F', '1989-09-17', 'Coach', 7500),
('021', '03', 'James', 'Carter', 'M', '1991-12-11', 'Coach', 6420),
('022', '04', 'Christen', 'Burchette', 'F', '1982-09-26', 'Coach', 9000),
('023', '04', 'Chad', 'Engle', 'M', '1998-07-18', 'Coach', 6400),
('024', '04', 'Andre', 'Cooper', 'M', '1990-11-05', 'Coach', 6000),
('025', '04', 'Jeffery', 'Cowan', 'M', '1979-07-24', 'Coach', 8000),
('026', '04', 'Anthony', 'Davis', 'M', '1987-03-14', 'Coach', 6000),
('027', '04', 'Stephanie', 'Stennett', 'F', '1990-04-15', 'Coach', 5200),
('028', '04', 'David', 'Gomez', 'M', '1985-08-23', 'Manager', 13000),
('029', '05', 'Beverly', 'Brumley', 'F', '1993-09-29', 'Coach', 8000),
('030', '05', 'Mary', 'Smith', 'F', '1993-01-02', 'Coach', 6000),
('031', '05', 'Calvin', 'Burke', 'M', '1988-12-14', 'Coach', 5500),
('032', '05', 'James', 'Henley', 'M', '1999-05-21', 'Coach', 4200),
('033', '05', 'Georgina', 'Patrick', 'F', '1999-02-07', 'Coach', 2200),
('034', '05', 'Vanita', 'Mansfield', 'F', '1994-06-12', 'Manager', 11000),
('035', '05', 'Donald', 'Hannan', 'M', '1997-04-12', 'Coach', 5100),
('036', '06', 'Molly', 'Sigel', 'F', '1993-05-09', 'Coach', 3900),
('037', '06', 'Anthony', 'Lyles', 'M', '1979-03-05', 'Manager', 13400),
('038', '06', 'Mattie', 'Patrick', 'F', '1996-07-08', 'Coach', 3200),
('039', '06', 'Ralph', 'Stewart', 'M', '1988-11-04', 'Coach', 10800),
('040', '06', 'Sarah', 'Best', 'F', '1975-12-26', 'Coach', 7800),
('041', '06', 'Harold', 'Lyles', 'M', '1999-10-21', 'Coach', 3400),
('042', '06', 'Elizabeth', 'Smith', 'F', '1988-12-03', 'Coach', 3000),
('043', '07', 'Julie', 'Davis', 'F', '1998-09-06', 'Coach', 8500),
('044', '07', 'David', 'Grant', 'M', '1983-04-09', 'Coach', 5800),
('045', '07', 'Shawn', 'Stewart', 'M', '1998-02-21', 'Coach', 4600),
('046', '07', 'Sue', 'Sawyer', 'F', '1989-03-30', 'Manager', 9900),
('047', '07', 'Rachel', 'Logan', 'F', '1991-08-21', 'Coach', 6250),
('048', '07', 'John', 'Sealey', 'M', '1995-04-30', 'Coach', 8400),
('049', '07', 'Cora', 'Holt', 'F', '1989-11-15', 'Coach', 9300),
('050', '08', 'Elizabeth', 'Ferguson', 'F', '1984-09-17', 'Coach', 5500),
('051', '08', 'James', 'White', 'M', '1993-11-11', 'Coach', 6420),
('052', '08', 'Christen', 'Jelks', 'F', '1982-10-26', 'Coach', 13000),
('053', '08', 'Allan', 'Engle', 'M', '1990-03-18', 'Coach', 6400),
('054', '08', 'Danny', 'Cooper', 'M', '1998-11-05', 'Coach', 10600),
('055', '08', 'Jeffery', 'Lynn', 'M', '1989-07-24', 'Manager', 18000),
('056', '08', 'Kenny', 'Davis', 'M', '1988-03-14', 'Coach', 6600),
('057', '09', 'Agnes', 'Williams', 'F', '1998-04-15', 'Coach', 4200),
('058', '09', 'David', 'Frith', 'M', '1981-08-23', 'Coach', 8000),
('059', '09', 'Callie', 'Tingle', 'F', '1997-09-29', 'Coach', 6800),
('060', '09', 'Donna', 'Smith', 'F', '1995-02-02', 'Coach', 4000),
('061', '09', 'James', 'Reynolds', 'M', '1993-12-11', 'Coach', 4420),
('062', '09', 'Dolores', 'Blumer', 'F', '1984-09-26', 'Manager', 9000),
('063', '09', 'Chad', 'Tingle', 'M', '1992-07-18', 'Coach', 6400),
('064', '10', 'Charlie', 'Cooper', 'M', '1991-11-05', 'Coach', 5000),
('065', '10', 'Jeffery', 'Davis', 'M', '1978-07-24', 'Coach', 8800),
('066', '10', 'James', 'Davis', 'M', '1988-03-14', 'Coach', 10000),
('067', '10', 'Cora', 'Stennett', 'F', '1999-04-15', 'Coach', 5200),
('068', '10', 'John', 'Gomez', 'M', '1989-08-23', 'Manager', 14000),
('069', '10', 'Sarah', 'Brumley', 'F', '1998-09-29', 'Coach', 7000),
('070', '10', 'Mary', 'Blumer', 'F', '1991-02-02', 'Coach', 4000);
SELECT * FROM Staff;


CREATE TABLE AnonymousEvaluationSystem
(EvaluationID VARCHAR(10) PRIMARY KEY,
 StaffID VARCHAR(10) REFERENCES Staff(StaffID),
 EvaluationTime DATE DEFAULT GETDATE(),
 Score INT CHECK(Score between 1 and 5) NOT NULL,
 Comments VARCHAR(100) DEFAULT 'None'
);
INSERT INTO AnonymousEvaluationSystem
(EvaluationID, StaffID, EvaluationTime, Score, Comments) VALUES
('001', '002', '2010-01-31', 5, 'Perfect'),
('002', '002', '2010-02-22', 4, 'Good'),
('003', '002', '2011-05-05', 5, 'Patient'),
('004', '002', '2011-12-11', 5, 'None'),
('005', '005', '2012-01-12', 4, 'So so'),
('006', '005', '2012-01-31', 5, 'Good teacher!'),
('007', '005', '2012-11-10', 5, 'None'),
('008', '004', '2013-02-03', 5, 'Helpful'),
('009', '004', '2013-07-14', 4, 'Not bad'),
('010', '009', '2013-11-10', 5, 'None'),
('011', '009', '2013-11-30', 3, 'So so'),
('012', '009', '2014-05-22', 4, 'Good'),
('013', '012', '2014-06-05', 4, 'Great'),
('014', '012', '2014-02-21', 5, 'None'),
('015', '014', '2014-06-12', 2, 'So so'),
('016', '014', '2015-01-31', 5, 'Perfect'),
('017', '014', '2015-11-10', 4, 'None'),
('018', '014', '2015-02-03', 5, 'Helpful'),
('019', '008', '2015-07-14', 4, 'Patient'),
('020', '008', '2015-11-10', 3, 'None'),
('021', '018', '2015-01-31', 5, 'Great'),
('022', '018', '2015-08-22', 4, 'Good'),
('023', '018', '2015-11-05', 5, 'Patient'),
('024', '020', '2016-04-11', 4, 'None'),
('025', '020', '2016-06-12', 3, 'So so'),
('026', '020', '2017-01-31', 5, 'Excellent'),
('027', '021', '2017-11-10', 3, 'None'),
('028', '021', '2018-02-03', 5, 'Really helpful'),
('029', '021', '2019-06-04', 4, 'Kind'),
('030', '015', '2019-12-10', 5, 'Excellent');
SELECT * FROM AnonymousEvaluationSystem;


CREATE TABLE Commodity
(CommodityID VARCHAR(10) PRIMARY KEY,
CommodityName VARCHAR(50),
MainFunction VARCHAR(100),
Price MONEY
);
INSERT INTO Commodity
(CommodityID, CommodityName, MainFunction, Price) VALUES
('101', 'Organic Beet Root Powder', 'low in calories and a great source of nutrients, including fiber, folate and vitamin C',25.99),
('102', 'GoBiotix Prebiotic Fiber Boost Powder','Support a Healthy Gut & Digestive Regularity, Feed Good Bacteria, Ease Gas',24.97),
('103', 'Citracal Slow Release 1200', 'Bone Health Supplement for Adults', 25.25),
('104', 'Turmeric & Ginger', 'Anti-Inflammatory, Antioxidant, Anti-Aging Supplement for Optimal Fitness',15.97),
('105', 'Sascha Fitness Fat Loss pills', 'Weight Loss Supplements', 49.99),
('106', 'Sascha Fitness Cortisol Night Support Pills', 'Metabolism Support', 79.99),
('107', 'Optimum Nutrition Amino Energy', 'Pre Workout with Green Tea, BCAA, Amino Acids, Keto Friendly', 20.99),
('108', 'Animal Cuts', 'Energy Booster', 38.95),
('109', 'Caffeine Pills', '220mg of Pure Caffeine, Energy Pills for Preworkout', 7.49),
('110', 'CLIF BARS', 'Energy Bars', 19.99),
('111', 'GoMacro MacroBar Organic Vegan Protein Bars', 'Energy Bars', 29.45),
('112', 'Solimo Energy Shot', 'Energy Shot', 15.99);
SELECT * FROM Commodity;


CREATE TABLE Curriculum
(CurriculumID VARCHAR(10) PRIMARY KEY,
CurriculumName VARCHAR(50),
DAY_OF_WEEK TINYINT CHECK (DAY_OF_WEEK BETWEEN 1 AND 7),
ClassTime TIME(0),
MainTarget VARCHAR(100),
CaloriesBurned INT,
TuitionPerClass MONEY
);
INSERT INTO Curriculum
(CurriculumID, CurriculumName, DAY_OF_WEEK, ClassTime, MainTarget, CaloriesBurned, TuitionPerClass) VALUES
('A01', 'Total Body Blast', 1,'7:00 PM', 'Full Body Strength and Cardio', 150, 150),
('A02', 'Cardio Strength', 1, '10:00 PM', 'Create a heart pumping workout', 200, 160),
('B01', 'Fat Burn Strength', 2, '7:00 PM', 'Train your body to be more efficient at burning fat', 300, 150),
('A03', 'Triple Metcon', 3,'7:00 PM','The class has three "Metcons" (metobolic conditioning) intervals and builds intensity', 300, 200),
('C01', 'Pilates', 3, '6:30 PM','Building core strength, increasing stability', 150, 200),
('B02', 'Ultimate', 2, '10:00 PM', '60 minutes of cardio, strength and core', 400, 250),
('C02', 'Yoga sculpt', 4, '6:00 PM', 'Build strength and tone all the major muscle groups', 150, 250),
('C03', 'cardio boxing', 4, '7:00 PM', 'Combines boxing techniques with high-intensity cardio training for a full-body workout', 300, 250),
('B03', 'HIIT', 5, '8:00 PM','Intense cardio bursts followed by short recovery periods', 400, 300),
('C04', 'Barre', 5,'7:00 PM','Building strength and endurance while combining elements of ballet technique', 200, 300),
('A04', 'sculpt', 3, '7:30 PM', 'Focuses on toning, lengthening, and sculpting your body', 150, 250),
('C05', 'Prenatal + Postnatal', 1, '8:00 PM', 'Support your fitness and health before and after childbirth', 150, 200);
SELECT * FROM Curriculum;


CREATE TABLE DietPlan
(DietPlanID VARCHAR(10) PRIMARY KEY,
DietPlanName VARCHAR(50),
HowitWorks VARCHAR(100),
WeightLoss VARCHAR(100),
OtherBenifits VARCHAR(100),
DownSides VARCHAR(100)
);
INSERT INTO DietPlan
(DietPlanID, DietPlanName,HowitWorks,
WeightLoss, OtherBenifits, DownSides) VALUES
('1', 'Intermittent fasting', 'Reducing your calorie intake by restricting the time you are allowed to eat.',
'10 kg weight loss over 3 weeks', 'anti-aging effects, increase insulin sensitivity, improve brain health and reduce inflammation',
'safe for most healthy adults'),
('2', 'Plant-based diets','Eliminating all meat, poultry, and fish', 'effective for weight loss',
'reducing risk of chronic conditions', 'restricing important nutrients that are typically found in animal products'),
('3', 'Low-carb diets', 'Restricting your carb intake in favor of protein and fat',
'more effective than conventional low-fat diets', 'improving blood sugar and insulin levels in people with type 2 diabetes',
'May raise LDL (bad) cholesterol levels'),
('4', 'The paleo diet','advocating eating whole foods', 'Can aid weight loss and reduce harmful belly fat',
'Reducing several heart disease risk factors', 'it restricts several nutritious food groups'),
('5', 'Low-fat diets', 'Restricting fat intake', 'Can aid weight loss',
'Reducing risk of heart disease and stroke', 'Restricting fat too much can lead to health problems in the long term'),
('6', 'The Mediterranean diet', 'Advocating eating plenty of healthy food and extra virgin olive oil',
'It is not specifically a weight loss diet', 'help combat inflammation and oxidative stress', 'It is not strictly a weight loss diet'),
('7', 'Weight Watchers', 'Assigns different foods and beverages a value, depending on their calorie, fat, and fiber contents', 'can help lose weight',
'WW allows flexibility, making it easy to follow.', 'It is flexibility can be a downfall if dieters choose unhealthy foods'),
('8', 'The DASH diet', 'Recommends specific servings of different food groups', 'can help lose weight',
'Reducing blood pressure levels and several heart disease risk factors', 'Eating too little salt has been linked to increased insulin resistance');
SELECT * FROM DietPlan;


CREATE TABLE MemberPhysicalCondition
(PhysicalConditionID VARCHAR(10) PRIMARY KEY,
Gender VARCHAR(5) CHECK(Gender IN ('M','F')) NOT NULL,
DateOfBirth Date,
Age AS DATEDIFF(HOUR, DateOfBirth, GETDATE())/8766,
Height_CM FLOAT,
Weight_KG FLOAT,
BodyFatPercentage FLOAT
);
INSERT INTO MemberPhysicalCondition
(PhysicalConditionID, Gender, DateOfBirth,
Height_CM, Weight_KG, BodyFatPercentage) VALUES
('1001','M','01-02-1990',177.5, 75.4, 33.2),
('1002','M','07-14-1985',172.0, 65.8, 28.3),
('1003','F','04-15-1997', 168.0, 50.4, 18.6),
('1004','F','11-01-1968', 162.3, 55.0, 25.4),
('1005','F','08-31-1992', 158.6, 46.7, 21.7),
('1006','M','06-15-1967', 171.3, 70.2, 30.0),
('1007','M','03-06-2000', 183.0, 65.8, 24.9),
('1008','M','09-27-1989', 175.2, 80.5, 38.4),
('1009','M','02-13-1991', 178.2, 77.0, 34.9),
('1010','F','09-12-1995', 171.2, 50.0, 19.6),
('1011','F','12-23-1973', 155.0, 50.0, 27.5),
('1012','F','05-19-1988', 165.0, 60.3, 28.0),
('1013','M','01-04-1998', 178.5, 65.4, 33.2),
('1014','M','06-14-1995', 172.0, 67.8, 31.3),
('1015','F','08-15-1997', 168.0, 51.4, 17.6),
('1016','F','11-01-1978', 165.3, 65.0, 25.4),
('1017','M','05-31-1992', 160.6, 56.7, 22.7),
('1018','M','07-15-1977', 173.3, 71.2, 30.1),
('1019','M','03-16-2000', 183.3, 64.8, 34.9),
('1020','M','09-27-1989', 172.2, 81.5, 35.4),
('1021','M','02-13-1991', 178.2, 78.0, 33.9),
('1022','F','09-12-1995', 176.2, 56.0, 29.6),
('1023','F','12-21-1983', 154.0, 53.0, 27.5),
('1024','F','01-03-1990', 187.5, 95.4, 23.2),
('1025','M','06-14-1985', 172.0, 64.8, 18.3),
('1026','F','06-15-1997', 169.0, 51.4, 19.6),
('1027','F','11-11-1978', 165.3, 55.0, 28.4),
('1028','F','08-30-1996', 156.6, 43.7, 21.7),
('1029','M','08-15-1969', 174.3, 74.2, 30.0),
('1030','M','02-16-2001', 186.0, 69.8, 20.9);
SELECT * FROM MemberPhysicalCondition;


CREATE TABLE Flow
(FlowID VARCHAR(10) PRIMARY KEY,
 FlowDate DATE NOT NULL
);
INSERT INTO Flow
(FlowID, FlowDate) VALUES
('001', '2006-01-03'),('002', '2006-01-03'),('003', '2006-01-15'),('004', '2006-07-10'),('005', '2006-08-01'),
('006', '2006-07-14'),('007', '2006-05-16'),('008', '2006-05-17'),('009', '2006-05-20'),('010', '2006-10-02'),
('011', '2006-10-07'),('012', '2006-10-10'),('013', '2006-01-04'),('014', '2006-01-05'),('015', '2006-01-10'),
('016', '2006-02-07'),('017', '2006-02-10'),('018', '2006-02-07'),('019', '2006-07-29'),('020', '2006-07-27'),
('021', '2006-08-01'),('022', '2006-11-17'),('023', '2006-11-20'),('024', '2006-11-19'),('025', '2006-03-18'),
('026', '2006-03-19'),('027', '2006-03-15'),('028', '2006-08-22'),('029', '2006-08-24'),('030', '2006-08-24'),
('031', '2006-02-21'),('032', '2006-05-10'),('033', '2006-08-21'),('034', '2006-09-20'),('035', '2007-01-21'),
('036', '2007-01-21'),('037', '2007-02-05'),('038', '2007-04-12'),('039', '2007-04-21'),('040', '2007-06-05'),
('041', '2007-09-21'),('042', '2007-10-05'),('043', '2008-02-05'),('044', '2008-04-05'),('045', '2008-06-05'),
('046', '2008-08-18'),('047', '2008-12-19'),('048', '2009-01-05'),('049', '2009-03-15'),('050', '2009-05-15'),
('051', '2009-06-13'),('052', '2009-07-13'),('053', '2009-08-05'),('054', '2009-09-01'),('055', '2009-09-12'),
('056', '2009-10-01'),('057', '2009-11-07'),('058', '2009-11-19'),('059', '2009-12-01'),('060', '2009-12-23'),
('061', '2010-02-21'),('062', '2010-05-10'),('063', '2010-08-21'),('064', '2010-09-20'),('065', '2011-01-21'),
('066', '2011-01-21'),('067', '2011-02-05'),('068', '2011-04-12'),('069', '2011-04-21'),('070', '2011-06-05'),
('071', '2011-09-21'),('072', '2011-10-05'),('073', '2012-02-05'),('074', '2012-04-05'),('075', '2012-06-05'),
('076', '2012-08-18'),('077', '2012-12-19'),('078', '2013-01-05'),('079', '2013-03-15'),('080', '2013-05-15'),
('081', '2013-06-13'),('082', '2013-07-13'),('083', '2013-08-05'),('084', '2013-09-01'),('085', '2013-09-12'),
('086', '2013-10-01'),('087', '2013-11-07'),('088', '2013-11-19'),('089', '2013-12-01'),('090', '2013-12-23'),
('091', '2010-01-03'),('092', '2010-01-03'),('093', '2010-01-15'),('094', '2010-07-10'),('095', '2010-07-11'),
('096', '2011-03-14'),('097', '2011-05-18'),('098', '2011-05-19'),('099', '2011-05-20'),('100', '2011-10-02'),
('101', '2012-01-07'),('102', '2012-10-11'),('103', '2012-11-04'),('104', '2012-11-05'),('105', '2012-12-20'),
('106', '2013-02-07'),('107', '2013-03-10'),('108', '2013-02-12'),('109', '2013-07-21'),('110', '2014-07-27'),
('111', '2014-08-01'),('112', '2014-11-17'),('113', '2014-11-20'),('114', '2014-11-19'),('115', '2014-03-18'),
('116', '2015-03-19'),('117', '2015-03-15'),('118', '2015-08-22'),('119', '2015-08-24'),('120', '2015-08-25'),
('121', '2016-02-21'),('122', '2016-05-10'),('123', '2016-08-21'),('124', '2016-09-20'),('125', '2017-01-21'),
('126', '2017-01-21'),('127', '2017-02-05'),('128', '2017-04-12'),('129', '2017-04-21'),('130', '2017-06-05'),
('131', '2017-09-21'),('132', '2017-10-05'),('133', '2018-02-05'),('134', '2018-04-05'),('135', '2018-06-05'),
('136', '2018-08-18'),('137', '2018-12-19'),('138', '2019-01-05'),('139', '2019-03-15'),('140', '2019-05-15'),
('141', '2019-06-13'),('142', '2019-07-13'),('143', '2019-08-05'),('144', '2019-09-01'),('145', '2019-09-12'),
('146', '2019-10-01'),('147', '2019-11-07'),('148', '2019-11-19'),('149', '2019-12-01'),('150', '2019-12-23');
SELECT * FROM Flow;


CREATE TABLE Member
(MemberID VARCHAR(10) PRIMARY KEY NOT NULL,
PhysicalConditionID VARCHAR(10) REFERENCES MemberPhysicalCondition(PhysicalConditionID),
DietPlanID VARCHAR(10) REFERENCES DietPlan(DietPlanID),
FirstName VARCHAR(50),
LastName VARCHAR(50) NOT NULL
);
INSERT INTO Member
(MemberID, PhysicalConditionID, DietPlanID, FirstName, LastName) VALUES
('01', NULL, NULL, 'James', 'Williams'), ('02', '1001', '3', 'Henry', 'Miller'),   
('03', '1002', NULL, 'Alexander', 'Moore'), ('04', NULL, '1', 'Charlotte', 'Lee'),    
('05', '1003', '6', 'Elizabeth', 'White'), ('06', '1004', '2', 'Sofia', 'Robinson'), 
('07', '1005', '7', 'Sherry', 'Green'),   ('08', '1006', NULL, 'Matthew', 'Adams'),
('09', '1007', '6', 'Tony', 'Carter'), ('10',NULL, '3', 'John', 'Nelson'),      
('11', NULL, '1', 'Luna', 'Flores'), ('12', NULL, NULL, 'Dylan', 'Nguyen'),
('13', '1008', '5', 'Isaac', 'Young'), ('14', NULL, '4', 'Abigail', 'Scott'),
('15', '1009', '1', 'Austin', 'King'), ('16', NULL, NULL, 'Mia', 'Sanchez'), 
('17', '1010', '7', 'Olivia', 'Clark'), ('18', NULL, '8', 'Nolan', 'Thomas'), 
('19', '1011', '3', 'Camila', 'Martinez'), ('20', '1012', '5', 'Penelope', 'Gonzalez'),
('21', NULL, '4', 'James', 'White'), ('22', '1013', '4', 'Henry', 'Gonzalez'),   
('23', '1014', '5', 'Tony', 'Moore'), ('24', NULL, '5', 'Charlotte', 'Black'),    
('25', '1015', '6', 'Cora', 'Lee'), ('26', '1016', '2', 'Sofia', 'Miller'), 
('27', '1017', '6', 'Howard', 'Maestas'),   ('28', '1018', NULL, 'Donald', 'Lewis'),
('29', '1019', '4', 'Scott', 'Baker'), ('30', '1020', '5', 'Robert', 'Stewart'),      
('31', '1021', '2', 'Devon', 'Flores'), ('32', '1022', NULL, 'Jane', 'Nguyen'),
('33', '1023', '1', 'Peggy', 'Young'), ('34', '1024', '1', 'Jennifer', 'Scott'),
('35', '1025', '2', 'Henry', 'King'), ('36', '1026', NULL, 'Mia', 'Sanchez'), 
('37', '1027', '3', 'Yvette', 'McLean'), ('38', '1028', '8', 'Beverly', 'Martinez'), 
('39', '1029', '7', 'Gary', 'Thomas'), ('40', '1030', '3', 'Arnold', 'Gonzalez');
SELECT * FROM Member;


CREATE TABLE Membership
(MembershipID VARCHAR(10) PRIMARY KEY,
 FlowID VARCHAR(10) UNIQUE NOT NULL REFERENCES Flow(FlowID),
 GymID VARCHAR(10) REFERENCES Gym(GymID) NOT NULL,
 MembershipTypeID VARCHAR(10) REFERENCES MembershipType(MembershipTypeID) NOT NULL,
 StartDate DATE DEFAULT GETDATE(),
 ExpireDate DATE NOT NULL,
 MemberID VARCHAR(10) NOT NULL REFERENCES Member(MemberID)
);
INSERT INTO Membership
(FlowID, MembershipID, GymID, MembershipTypeID, StartDate, ExpireDate, MemberID) VALUES
('031', '001', '01', '1', '2006-02-21', '2006-02-22', '01'), ('032', '002', '01', '6', '2006-05-10', '2007-05-10', '01'),
('033', '003', '01', '3', '2006-08-21', '2006-09-21', '02'), ('034', '004', '01', '2', '2006-09-20', '2006-09-27', '03'),
('035', '005', '02', '4', '2007-01-21', '2007-04-21', '04'), ('036', '006', '02', '5', '2007-01-21', '2007-07-21', '05'),
('037', '007', '03', '1', '2007-02-05', '2007-02-06', '06'), ('038', '008', '03', '6', '2007-04-12', '2008-04-12', '06'),
('039', '009', '03', '7', '2007-04-21', '2009-04-21', '07'), ('040', '010', '02', '1', '2007-06-05', '2007-09-06', '08'),
('041', '011', '02', '3', '2007-09-21', '2007-10-21', '08'), ('042', '012', '03', '4', '2007-10-05', '2008-01-05', '09'),
('043', '013', '01', '1', '2008-02-05', '2008-02-06', '10'), ('044', '014', '01', '2', '2008-04-05', '2008-04-12', '10'), 
('045', '015', '01', '6', '2008-06-05', '2009-06-05', '10'), ('046', '016', '02', '2', '2008-08-18', '2008-08-25', '11'), 
('047', '017', '02', '5', '2008-12-19', '2009-06-19', '11'), ('048', '018', '03', '4', '2009-01-05', '2009-04-05', '12'), 
('049', '019', '01', '1', '2009-03-15', '2009-03-16', '13'), ('050', '020', '01', '6', '2009-05-15', '2010-05-15', '13'), 
('051', '021', '02', '3', '2009-06-13', '2009-07-13', '14'), ('052', '022', '02', '7', '2009-07-13', '2011-07-13', '14'), 
('053', '023', '02', '1', '2009-08-05', '2009-08-06', '15'), ('054', '024', '02', '8', '2009-09-01', '2099-12-31', '15'), 
('055', '025', '02', '4', '2009-09-12', '2009-12-12', '16'), ('056', '026', '03', '3', '2009-10-01', '2009-11-01', '17'), 
('057', '027', '03', '5', '2009-11-07', '2010-05-07', '18'), ('058', '028', '01', '5', '2009-11-19', '2010-05-19', '19'), 
('059', '029', '01', '1', '2009-12-01', '2009-12-02', '20'), ('060', '030', '01', '3', '2009-12-23', '2010-01-23', '20'),
('061', '031', '01', '1', '2010-02-21', '2010-02-22', '21'), ('062', '032', '01', '6', '2010-05-10', '2011-05-10', '21'),
('063', '033', '01', '3', '2010-08-21', '2010-09-21', '22'), ('064', '034', '01', '2', '2010-09-20', '2010-09-27', '23'),
('065', '035', '02', '4', '2011-01-21', '2011-04-21', '24'), ('066', '036', '02', '5', '2011-01-21', '2011-07-21', '25'),
('067', '037', '03', '1', '2011-02-05', '2011-02-06', '26'), ('068', '038', '03', '6', '2011-04-12', '2012-04-12', '26'),
('069', '039', '03', '7', '2011-04-21', '2011-04-21', '27'), ('070', '040', '01', '1', '2011-06-05', '2011-06-06', '28'),
('071', '041', '01', '3', '2011-09-21', '2011-10-21', '28'), ('072', '042', '01', '4', '2011-10-05', '2012-01-05', '29'),
('073', '043', '02', '1', '2012-02-05', '2012-02-06', '30'), ('074', '044', '02', '2', '2012-04-05', '2012-04-12', '30'), 
('075', '045', '02', '6', '2012-06-05', '2013-06-05', '30'), ('076', '046', '02', '2', '2012-08-18', '2012-08-25', '31'), 
('077', '047', '02', '5', '2012-12-19', '2013-06-19', '31'), ('078', '048', '02', '4', '2013-01-05', '2013-04-05', '32'), 
('079', '049', '03', '1', '2013-03-15', '2013-03-16', '33'), ('080', '050', '03', '6', '2013-05-15', '2014-05-15', '33'), 
('081', '051', '02', '3', '2013-06-13', '2013-07-13', '34'), ('082', '052', '02', '7', '2013-07-13', '2015-07-13', '34'), 
('083', '053', '02', '1', '2013-08-05', '2013-08-06', '35'), ('084', '054', '02', '8', '2013-09-01', '2099-12-31', '35'), 
('085', '055', '02', '4', '2013-09-12', '2013-12-12', '36'), ('086', '056', '03', '3', '2013-10-01', '2013-11-01', '37'), 
('087', '057', '03', '5', '2013-11-07', '2014-05-07', '38'), ('088', '058', '01', '5', '2013-11-19', '2014-05-19', '39'), 
('089', '059', '01', '1', '2013-12-01', '2013-12-02', '40'), ('090', '060', '01', '3', '2013-12-23', '2014-01-23', '40');
SELECT * FROM Membership;


CREATE TABLE Equipment
(EquipmentID VARCHAR(10) PRIMARY KEY,
 FlowID VARCHAR(10) REFERENCES Flow(FlowID) NOT NULL,
 GymID VARCHAR(10) REFERENCES Gym(GymID) NOT NULL,
 Name VARCHAR(50) NOT NULL,
 Price MONEY NOT NULL
);
INSERT INTO Equipment
(EquipmentID, FlowID, GymID, Name, Price) VALUES
('01', '001', '01', 'Treadmill', 300),('02', '002', '01', 'Spinning', 200),('03', '003', '01', 'Dumbbell', 40),
('04', '004', '02', 'Treadmill', 330),('05', '005', '02', 'Spinning', 232),('06', '006', '02', 'Dumbbell', 55),
('07', '007', '03', 'Treadmill', 378),('08', '008', '03', 'Spinning', 210),('09', '009', '03', 'Dumbbell', 100),
('10', '010', '04', 'Treadmill', 500),('11', '011', '04', 'Spinning', 420), ('12', '012', '04', 'Dumbbell', 80),
('13', '013', '05', 'Treadmill', 650),('14', '014', '05', 'Spinning', 450),('15', '015', '05', 'Dumbbell', 100),
('16', '016', '06', 'Treadmill', 700),('17', '017', '06', 'Spinning', 500),('18', '018', '06', 'Dumbbell', 120),
('19', '019', '07', 'Treadmill', 900),('20', '020', '07', 'Spinning', 780),('21', '021', '07', 'Dumbbell', 200),
('22', '022', '08', 'Treadmill', 980),('23', '023', '08', 'Spinning', 820),('24', '024', '08', 'Dumbbell', 212),
('25', '025', '09', 'Treadmill', 1000),('26', '026', '09', 'Spinnning', 828),('27', '027', '09', 'Dumbbell', 240),
('28', '028', '10', 'Treadmill', 1005),('29', '029', '10', 'Spinning', 830),('30', '030', '10', 'Dumbbell', 240);
SELECT * FROM Equipment;


CREATE TABLE CommodityBought
(FlowID VARCHAR(10) PRIMARY KEY REFERENCES Flow(FlowID),
MemberID VARCHAR(10) REFERENCES Member(MemberID),
CommodityID VARCHAR(10) REFERENCES Commodity(CommodityID),
StaffID VARCHAR(10) REFERENCES Staff(StaffID),
Quantity INT
);
INSERT INTO CommodityBought
(FlowID, MemberID, CommodityID, StaffID, Quantity) VALUES
('091', '01', '103', '001', 20), ('092', '13', '105', '001', 40),
('093', '20', '112', '001', 50), ('094', '28', '101', '004', 10),
('095', '23', '104', '004', 20),('096', '05', '107', '009', 30),
('097', '05', '108', '009', 40), ('098', '11', '110', '011', 80),
('099', '15', '111', '011', 10), ('100', '23', '103', '011', 20), 
('101', '18', '111', '018', 10), ('102', '27', '102', '018', 30), 
('103', '33', '108', '018', 50), ('104', '18', '109', '018', 30), 
('105', '38', '101', '018', 40);
SELECT * FROM CommodityBought;


CREATE TABLE MemberCoachCurriculum
(FlowID VARCHAR(10) PRIMARY KEY REFERENCES Flow(FlowID), 
 MemberID VARCHAR(10) REFERENCES Member(MemberID),
 CurriculumID VARCHAR(10) REFERENCES Curriculum(CurriculumID),
 StaffID VARCHAR(10) REFERENCES Staff(StaffID)
);
INSERT INTO MemberCoachCurriculum
(FlowID, MemberID, CurriculumID, StaffID) VALUES
('106', '01', 'A02', '002'), ('107', '04', 'B01', '010'),
('108', '05', 'C05', '012'), ('109', '06', 'A04', '016'),
('110', '07', 'B02', '017'), ('111', '08', 'A01', '010'),
('112', '08', 'C02', '010'), ('113', '11', 'A03', '012'),
('114', '12', 'C03', '016'), ('115', '13', 'A01', '005'),
('116', '13', 'B02', '005'), ('117', '17', 'C04', '017'),
('118', '18', 'A03', '016'), ('119', '19', 'B02', '002'),
('120', '20', 'C03', '002'), ('121', '01', 'A02', '005'), 
('122', '04', 'B01', '012'), ('123', '05', 'C05', '010'), 
('124', '06', 'A04', '017'), ('125', '07', 'B02', '016'), 
('126', '08', 'A01', '012'), ('127', '08', 'C02', '012'), 
('128', '11', 'A03', '010'), ('129', '12', 'C03', '017'), 
('130', '13', 'A01', '002'), ('131', '13', 'B02', '002'), 
('132', '17', 'C04', '016'), ('133', '18', 'A03', '017'), 
('134', '19', 'B02', '005'), ('135', '20', 'C03', '002'),
('136', '23', 'B02', '005'), ('137', '27', 'C04', '016'),
('138', '28', 'A03', '002'), ('139', '29', 'B02', '005'),
('140', '28', 'C03', '002'), ('141', '31', 'A02', '010'), 
('142', '34', 'B01', '012'), ('143', '36', 'C05', '010'), 
('144', '36', 'A04', '012'), ('145', '37', 'B02', '017'),
('146', '33', 'B02', '016'), ('147', '37', 'C04', '017'),
('148', '38', 'A03', '016'), ('149', '39', 'B02', '005'),
('150', '40', 'C03', '002');
SELECT * FROM MemberCoachCurriculum;


-- Create at least 2 views

CREATE VIEW MembershipExpireDate AS
SELECT m.MemberID, m.FirstName, m.LastName, MAX(ms.ExpireDate) AS ExpireDate
FROM MEMBER m
INNER JOIN Membership ms
ON m.MemberID = ms.MemberID
GROUP BY m.MemberID, m.FirstName, m.LastName;

SELECT * FROM MembershipExpireDate;

CREATE VIEW CurriculumSize AS
SELECT mcc.CurriculumID, c.CurriculumName, COUNT(mcc.MemberID) AS NumOfMembers 
FROM MemberCoachCurriculum mcc
INNER JOIN Curriculum c
ON mcc.CurriculumID = c.CurriculumID
GROUP BY mcc.CurriculumID, c.CurriculumName;

SELECT * FROM CurriculumSize;

CREATE VIEW CoachEvaluation AS
SELECT s.StaffID, s.GymID, s.FirstName, s.LastName, s.Gender, s.Age, CAST(AVG(CAST(aes.Score AS FLOAT)) AS DECIMAL(10,2)) AS Score
FROM Staff s
INNER JOIN AnonymousEvaluationSystem aes
ON s.StaffID = aes.StaffID
GROUP BY s.StaffID, s.GymID, s.FirstName, s.LastName, s.Gender, s.Age;

SELECT * FROM CoachEvaluation
ORDER BY GymID;

CREATE VIEW IncomeMembership AS
SELECT m.MemberID, m.MembershipTypeID, m.GymID, t.MembershipFee
FROM Membership m
JOIN MembershipType t
ON m.MembershipTypeID = t.MembershipTypeID

SELECT * FROM IncomeMembership;

CREATE VIEW IncomeCurriculumn AS
SELECT m.MemberID, m.CurriculumID, c.TuitionPerClass, s.GymID, s.StaffID,
mpc.BodyFatPercentage, mpc.Gender, mpc.Height_CM, mpc.Weight_KG, mpc.Age
FROM MemberCoachCurriculum m
JOIN Curriculum C
ON m.CurriculumID = C.CurriculumID
JOIN Staff s
ON s.StaffID =  m.StaffID
JOIN Member mb
ON m.MemberID = mb.MemberID
JOIN MemberPhysicalCondition mpc
ON mb.PhysicalConditionID = mpc.PhysicalConditionID

SELECT * FROM IncomeCurriculumn;

CREATE VIEW IncomeCommodity AS
SELECT FlowID, MemberID, c.CommodityID , StaffID, Quantity, Price, Quantity*Price as TotalSale
FROM Commodity c
JOIN CommodityBought b
ON c. CommodityID = b.CommodityID

SELECT * FROM IncomeCommodity;

-- Table-level CHECK Constraints based on a function

-- 1.Check if members have already registered for three lessons, they can not register any more lessons(unable to insert).
Go
CREATE FUNCTION CheckWorkLoad(@memID INT)
RETURNS INT
AS
BEGIN
	DECLARE @count INT=0
		SELECT @count=COUNT(MemberID) FROM MemberCoachCurriculum
	 	WHERE @memID=MemberID
	RETURN @count
END
Go

ALTER TABLE MemberCoachCurriculum WITH NOCHECK
ADD CONSTRAINT AvoidBurden
CHECK(dbo.CheckWorkLoad(MemberID)<4);

INSERT INTO MemberCoachCurriculum VALUES
('001', '11', 'A02', '002'), ('002', '11', 'B02', '009'),
('003', '11', 'C02', '0011'), ('004', '11', 'C04', '026');
-- Fail to insert due to too many courses


-- 2.Check function for retiring old equipments(unable to insert) if they are bought 5 years ago	   
-- function cannot be based on temp table

GO
CREATE FUNCTION CheckUsageTime(@equipID INT)
RETURNS INT
AS
BEGIN 
	RETURN ( 
	SELECT DATEDIFF(YEAR, f.FlowDate, GETDATE()) 
	FROM Equipment e
	JOIN Flow f
	ON e.FlowID=f.FlowID
   	WHERE e.EquipmentID=@equipID
	)
END;
Go

ALTER TABLE Equipment WITH NOCHECK
ADD CONSTRAINT ObsoleteEquipment
CHECK (dbo.CheckUsageTime(EquipmentID)<6);

DELETE FROM Equipment WHERE EquipmentID = '100'
DELETE FROM Flow WHERE FlowID = '2000'
INSERT INTO Flow VALUES('2000', '2000-01-03')

INSERT INTO Equipment VALUES('100', '2000', '01', 'Treadmill', 300)
-- Fail to insert because of the excessive usage time;


-- 3.Check function for checking the expired membership(if expired, he/she cannot add any course anymore)

GO
CREATE FUNCTION CheckMembershipExpired(@MemberId varchar(10))
RETURNS SMALLINT
AS 
BEGIN
	DECLARE @tmp SMALLINT
	SET @tmp = 
		CASE WHEN GETDATE() > (SELECT MAX(ExpireDate) FROM Membership WHERE MemberID = 
						          (SELECT MemberID FROM Member WHERE MemberID = @MemberId))
			 THEN -1
			 ELSE 0
		END
	RETURN @tmp
END
GO

ALTER TABLE MemberCoachCurriculum WITH NOCHECK
ADD CONSTRAINT MembershipExpired CHECK 
(dbo.CheckMembershipExpired(MemberID)=0);

INSERT INTO Flow(FlowID, FlowDate) VALUES
('151', GETDATE())
INSERT INTO MemberCoachCurriculum(FlowID, MemberID, CurriculumID, StaffID) VALUES
('151', '01', 'A03', '003')
-- Fail to insert course because of the expiration


-- Computed Columns based on a function


-- 1.Calculate the total consumption of the each user on courses in the gym
GO
CREATE FUNCTION TotalConsumptionOnCourse
(@memberid INT)
RETURNS INT
AS 
BEGIN
	DECLARE @tuition INT=0
		SELECT @tuition=SUM(c.TuitionPerClass) 
		FROM MemberCoachCurriculum mcc
		JOIN Curriculum c
		ON mcc.CurriculumID=c.CurriculumID
		WHERE mcc.MemberID=@memberid
		GROUP BY mcc.MemberID
	RETURN @tuition
END;
GO

ALTER TABLE Member ADD TotalConsumption AS
(dbo.TotalConsumptionOnCourse(MemberID));

SELECT * FROM Member;


-- 2.Calculate the basal metabolic rate of each member by usage of data	on physical condition
Go
CREATE FUNCTION BMRCal(@PCID VARCHAR(10))
RETURNS INT
AS
BEGIN
    DECLARE @BMR FLOAT
      	SELECT @BMR = 88.362 + (13.397 * Weight_KG) + (4.799 * Height_CM) - (5.677 * Age)
	  	FROM MemberPhysicalCondition
      	WHERE PhysicalConditionID =@PCID AND Gender = 'M'
	  	SELECT @BMR = 447.593 + (9.247 * Weight_KG) + (3.098 * Height_CM) - (4.330 * Age)
	  	FROM MemberPhysicalCondition
	  	WHERE PhysicalConditionID =@PCID AND Gender = 'F'
    RETURN CAST(@BMR AS INT)
END;
Go

ALTER TABLE MemberPhysicalCondition
ADD BasalMetabolicRate AS (dbo.BMRCal(PhysicalConditionID));

SELECT * FROM MemberPhysicalCondition;
CREATE TABLE Clients (
    ClientID INT PRIMARY KEY,
    Name VARCHAR(100),
    ContactInfo VARCHAR(100)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Position VARCHAR(50),
    HireDate DATE
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    ClientID INT,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);

CREATE TABLE Tasks (
    TaskID INT PRIMARY KEY,
    TaskDescription TEXT,
    ProjectID INT,
    EmployeeID INT,
    DueDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Materials (
    MaterialID INT PRIMARY KEY,
    MaterialName VARCHAR(100),
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    ProjectID INT,
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

INSERT INTO Clients (ClientID, Name, ContactInfo) VALUES
(1, 'John Doe', 'john.doe@example.com'),
(2, 'Jane Smith', 'jane.smith@example.com');

INSERT INTO Employees (EmployeeID, Name, Position, HireDate) VALUES
(1, 'Alice Johnson', 'Engineer', '2020-01-15'),
(2, 'Bob Brown', 'Architect', '2019-03-20');

INSERT INTO Projects (ProjectID, ProjectName, ClientID, StartDate, EndDate) VALUES
(1, 'Project Alpha', 1, '2023-01-01', '2023-12-31'),
(2, 'Project Beta', 2, '2023-02-01', '2023-11-30');

INSERT INTO Tasks (TaskID, TaskDescription, ProjectID, EmployeeID, DueDate, Status) VALUES
(1, 'Design blueprint', 1, 2, '2023-02-15', 'Completed'),
(2, 'Foundation work', 1, 1, '2023-03-01', 'In Progress');

INSERT INTO Materials (MaterialID, MaterialName, Quantity, UnitPrice, ProjectID) VALUES
(1, 'Concrete', 100, 50.00, 1),
(2, 'Steel', 50, 100.00, 1);

SELECT ProjectName, COUNT(TaskID) AS TaskCount
FROM Projects
JOIN Tasks ON Projects.ProjectID = Tasks.ProjectID
GROUP BY ProjectName
ORDER BY TaskCount DESC;

SELECT Clients.Name AS ClientName, Projects.ProjectName, Employees.Name AS EmployeeName, Tasks.TaskDescription
FROM Clients
JOIN Projects ON Clients.ClientID = Projects.ClientID
JOIN Tasks ON Projects.ProjectID = Tasks.ProjectID
JOIN Employees ON Tasks.EmployeeID = Employees.EmployeeID;

CREATE VIEW ProjectTasks AS
SELECT Projects.ProjectName, Tasks.TaskDescription, Employees.Name AS EmployeeName
FROM Projects
JOIN Tasks ON Projects.ProjectID = Tasks.ProjectID
JOIN Employees ON Tasks.EmployeeID = Employees.EmployeeID;

SELECT TaskDescription,
       CASE
           WHEN Status = 'Completed' THEN 'Done'
           WHEN Status = 'In Progress' THEN 'Ongoing'
           ELSE 'Not Started'
       END AS TaskStatus
FROM Tasks;

SELECT ProjectName, COALESCE(EndDate, 'Not Completed') AS ProjectEndDate
FROM Projects;

CREATE FUNCTION GetProjectStatus(projectID INT)
RETURNS VARCHAR(20)
BEGIN
    DECLARE status VARCHAR(20);
    SELECT CASE
               WHEN EndDate IS NULL THEN 'In Progress'
               ELSE 'Completed'
           END INTO status
    FROM Projects
    WHERE ProjectID = projectID;
    RETURN status;
END;

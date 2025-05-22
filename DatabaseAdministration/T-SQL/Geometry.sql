-- =-========================================
-- Creating and Inserting Points
-- =-========================================

BEGIN TRAN
CREATE TABLE tblGeom (
    GXY geometry,                        -- Column to hold geometry data (spatial shapes)
    Description varchar(30),            -- Description of each geometry object
    IDtblGeom int CONSTRAINT PK_tblGeom PRIMARY KEY IDENTITY(1,1)  -- Unique ID with auto-increment
)

-- Inserting various geometries: single points using WKT and method, and one multipoint
INSERT INTO tblGeom
VALUES 
    (geometry::STGeomFromText('POINT (3 4)', 0), 'First point'),
    (geometry::STGeomFromText('POINT (3 5)', 0), 'Second point'),
    (geometry::Point(4, 6, 0), 'Third Point'),
    (geometry::STGeomFromText('MULTIPOINT ((1 2), (2 3), (3 4))', 0), 'Three Points')

-- Show inserted geometries
SELECT * FROM tblGeom
ROLLBACK TRAN  

-- =-========================================
-- Queries on Geometry Points
-- =-========================================

BEGIN TRAN
CREATE TABLE tblGeom (
    GXY geometry,
    Description varchar(20),
    IDtblGeom int CONSTRAINT PK_tblGeom PRIMARY KEY IDENTITY(1,1)
)

INSERT INTO tblGeom
VALUES 
    (geometry::STGeomFromText('POINT (3 4)', 0), 'First point'),
    (geometry::STGeomFromText('POINT (3 5)', 0), 'Second point'),
    (geometry::Point(4, 6, 0), 'Third Point'),
    (geometry::STGeomFromText('MULTIPOINT ((1 2), (2 3), (3 4))', 0), 'Three Points')

SELECT * FROM tblGeom

-- Extract geometry details: type, specific points, coordinates
SELECT 
    IDtblGeom,
    GXY.STGeometryType() AS MyType,               -- Type of geometry (e.g. POINT, MULTIPOINT)
    GXY.STStartPoint().ToString() AS StartingPoint,   -- First point (for lines)
    GXY.STEndPoint().ToString() AS EndingPoint,       -- Last point (for lines)
    GXY.STPointN(1).ToString() AS FirstPoint,         -- First point from multipoint
    GXY.STPointN(2).ToString() AS SecondPoint,        -- Second point (if exists)
    GXY.STPointN(1).STX AS FirstPointX,               -- X coordinate of first point
    GXY.STPointN(1).STY AS FirstPointY,               -- Y coordinate of first point
    GXY.STNumPoints() AS NumberPoints                 -- Total number of points in geometry
FROM tblGeom

-- Calculate distance between two geometries (ID 1 and ID 3)
DECLARE @g AS geometry
DECLARE @h AS geometry

SELECT @g = GXY FROM tblGeom WHERE IDtblGeom = 1
SELECT @h = GXY FROM tblGeom WHERE IDtblGeom = 3

SELECT @g.STDistance(@h) AS MyDistance
ROLLBACK TRAN


-- =-========================================
-- LINESTRINGs, POLYGONs, and CIRCULARSTRINGs
-- =-========================================

BEGIN TRAN
CREATE TABLE tblGeom (
    GXY geometry,
    Description varchar(20),
    IDtblGeom int CONSTRAINT PK_tblGeom PRIMARY KEY IDENTITY(5,1)  -- Start identity at 5
)

-- Insert line strings, polygon and circular string geometries
INSERT INTO tblGeom
VALUES 
    (geometry::STGeomFromText('LINESTRING (1 1, 5 5)', 0), 'First line'),              -- Simple line
    (geometry::STGeomFromText('LINESTRING (5 1, 1 4, 2 5, 5 1)', 0), 'Second line'),   -- Closed line loop
    (geometry::STGeomFromText('MULTILINESTRING ((1 5, 2 6), (1 4, 2 5))', 0), 'Third line'), -- Multiple lines, one statment
    (geometry::STGeomFromText('POLYGON ((4 1, 6 3, 8 3, 6 1, 4 1))', 0), 'Polygon'),   -- Polygon shaded. (Must start and end with the same point)
    (geometry::STGeomFromText('CIRCULARSTRING (1 0, 0 1, -1 0, 0 -1, 1 0)', 0), 'Circle') -- Circlular shape
SELECT * FROM tblGeom

-- {next part is continuation from the above part but talks on quering line strings etc.}
-- =-========================================
-- Geometry Analysis: Intersection, Distance, Union
-- =-========================================

-- Declare a variable for geometry reference (e.g., the Circle)
DECLARE @g AS geometry
SELECT @g = GXY FROM tblGeom WHERE IDtblGeom = 5  

-- Calculate intersection and distance between each object and the firstline
SELECT 
    IDtblGeom, 
    GXY.STIntersection(@g).ToString() AS Intersection,   -- Geometric overlap
    GXY.STDistance(@g) AS DistanceFromFirstLine          -- Distance to the firstline
FROM tblGeom

-- Perform a spatial union between the firstline and another shape (e.g., Polygon with ID 8)
SELECT 
    GXY.STUnion(@g) AS UnifiedShape,                     -- Combine the two geometries into one
    Description
FROM tblGeom
--WHERE IDtblGeom = 8  -- Assuming 8 is a valid ID, replace if necessary

rollback tran

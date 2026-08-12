DECLARE @BackupFile NVARCHAR(500) = N'$(BACKUPFILE)';
DECLARE @DataPath NVARCHAR(500) = N'$(DATAPATH)';
DECLARE @DBName NVARCHAR(128) = N'$(DBNAME)';

-- Tabla temporal con la estructura que devuelve FILELISTONLY
CREATE TABLE #FileList (
    LogicalName NVARCHAR(128),
    PhysicalName NVARCHAR(260),
    Type CHAR(1),
    FileGroupName NVARCHAR(128),
    Size NUMERIC(20,0),
    MaxSize NUMERIC(20,0),
    FileId BIGINT,
    CreateLSN NUMERIC(25,0),
    DropLSN NUMERIC(25,0),
    UniqueId UNIQUEIDENTIFIER,
    ReadOnlyLSN NUMERIC(25,0),
    ReadWriteLSN NUMERIC(25,0),
    BackupSizeInBytes BIGINT,
    SourceBlockSize INT,
    FileGroupId INT,
    LogGroupGUID UNIQUEIDENTIFIER,
    DifferentialBaseLSN NUMERIC(25,0),
    DifferentialBaseGUID UNIQUEIDENTIFIER,
    IsReadOnly BIT,
    IsPresent BIT,
    TDEThumbprint VARBINARY(32),
    SnapshotUrl NVARCHAR(360)
);

INSERT INTO #FileList
EXEC('RESTORE FILELISTONLY FROM DISK = ''' + @BackupFile + '''');

-- Arma el WITH MOVE dinámicamente para cada archivo
DECLARE @MoveClause NVARCHAR(MAX) = '';

SELECT @MoveClause = @MoveClause +
    'MOVE ''' + LogicalName + ''' TO ''' + @DataPath +
    LogicalName + CASE WHEN Type = 'L' THEN '.ldf' ELSE '.mdf' END + ''', '
FROM #FileList;

-- Saca la última coma
SET @MoveClause = LEFT(@MoveClause, LEN(@MoveClause) - 1);

DECLARE @SQL NVARCHAR(MAX) =
    'RESTORE DATABASE [' + @DBName + '] FROM DISK = ''' + @BackupFile + '''' +
    ' WITH ' + @MoveClause + ', REPLACE';

PRINT @SQL; -- por si querés revisarlo antes
EXEC(@SQL);

DROP TABLE #FileList;
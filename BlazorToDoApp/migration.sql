IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
CREATE TABLE [TodoItems] (
    [Id] int NOT NULL IDENTITY,
    [Task] nvarchar(100) NOT NULL,
    [IsCompleted] bit NOT NULL,
    CONSTRAINT [PK_TodoItems] PRIMARY KEY ([Id])
);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241215074208_AddTaskColumn', N'9.0.0');

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241215074436_InitialCreate', N'9.0.0');

DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TodoItems]') AND [c].[name] = N'Task');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [TodoItems] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [TodoItems] ALTER COLUMN [Task] nvarchar(max) NOT NULL;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241216070008_UpdateTodoContext', N'9.0.0');

ALTER TABLE [TodoItems] ADD [CreatedAt] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250108165112_AddCreatedAtToTodoItem', N'9.0.0');

DECLARE @var1 sysname;
SELECT @var1 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TodoItems]') AND [c].[name] = N'Task');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [TodoItems] DROP CONSTRAINT [' + @var1 + '];');
ALTER TABLE [TodoItems] ALTER COLUMN [Task] nvarchar(100) NOT NULL;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250108205914_UpdateTodoItemModel', N'9.0.0');

CREATE TABLE [Categories] (
    [CategoryId] int NOT NULL IDENTITY,
    [Name] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Categories] PRIMARY KEY ([CategoryId])
);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250112063540_AddCategoryTable', N'9.0.0');

ALTER TABLE [TodoItems] ADD [CategoryId] int NULL;

CREATE INDEX [IX_TodoItems_CategoryId] ON [TodoItems] ([CategoryId]);

ALTER TABLE [TodoItems] ADD CONSTRAINT [FK_TodoItems_Categories_CategoryId] FOREIGN KEY ([CategoryId]) REFERENCES [Categories] ([CategoryId]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250112072721_AddCategoryToTodoItem', N'9.0.0');

ALTER TABLE [TodoItems] ADD [DueDate] datetime2 NULL;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250115064903_AddDueDateToTodoItem', N'9.0.0');

COMMIT;
GO


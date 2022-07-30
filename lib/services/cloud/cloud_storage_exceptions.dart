class CloudStorageException implements Exception {
  const CloudStorageException();
}

// eninde sonunda bunların hepsi CloudStroageException diye bir çatı altında topladık
// C in CRUD
class CouldNotCreateNotesException extends CloudStorageException {}

// R in CRUD
class CouldNoteGetAllNotesException extends CloudStorageException {}

// U in CRUD
class CouldNoteUpdateNoteException extends CloudStorageException {}

// D in CRUD
class CouldNoteDeleteNoteException extends CloudStorageException {}

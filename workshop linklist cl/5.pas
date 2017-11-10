program TesLinklist;

type
  Point = ^Node;
  Node = record
    Info: integer;
    Next: Point;
  end;

var 
  Awal, Akhir, Baru, Bantu: Point;

procedure Create;
begin
  Awal := nil;
  Akhir := nil;  
end;

procedure AddFirst(nilai: integer);
begin
  new(Baru);
  Baru^.Info := nilai;

  if(Awal = nil) then
  begin
    Baru^.Next := nil;
    Akhir := Baru;
  end
  else
    Baru^.Next := Awal;
  
  Awal := Baru;
end;

procedure Traversal;
begin
  if(Awal = nil) then
    writeln('List kosong')
  else 
  begin
    Bantu := Awal;
    while(Bantu <> nil) do
    begin
      writeln(Bantu^.Info);
      Bantu := Bantu^.Next;
    end;
  end;
end;

begin
  Create;
  AddFirst(5);
  AddFirst(10);
  AddFirst(7);
  Traversal;
end.

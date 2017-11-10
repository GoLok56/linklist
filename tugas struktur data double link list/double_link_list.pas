program Double_Link_List_Data_Transaksi;
uses crt;
{I.S. : User memasukkan data transaksi }
{F.S. : Menampilkan data transaksi yang sudah terurut berdasarkan kode }
type
    Point = ^Data;
    Transaksi = record
        Kode, NamaPembeli, TanggalTransaksi : string;
    end;
    Data = record
        Info : Transaksi;
        Prev, Next : Point;
    end;

var
    Awal, Akhir : Point;
    MenuUtama, SubMenu : integer;

procedure ValidasiMenu(var Menu : integer; Min, Max : integer);
{I.S. : Menu yang dipilih user telah terdefinisi }
{F.S. : Melakukan validasi pada pilihan user }
begin   
    while(Menu < Min) or (Menu > Max) do
    begin
        gotoxy(33,16);
        textcolor(red);write('Menu tidak ditemukan!');
        textcolor(7);readln;
        gotoxy(33,16);clreol;
        gotoxy(53,15);clreol;
        readln(Menu);
    end;
end;

function DataTransaksi() : Transaksi;
{I.S. : User memasukkan data tiap field transaksi }
{F.S. : Menghasilkan data Transaksi baru }
var
    Data : Transaksi;
begin
    clrscr;
    gotoxy(28,11);write('Kode Transaksi    : ');readln(Data.Kode);
    gotoxy(28,12);write('Nama Pembeli      : ');readln(Data.NamaPembeli);
    gotoxy(28,13);write('Tanggal Transaksi : ');readln(Data.TanggalTransaksi);
    DataTransaksi := Data;
end;

function CekString(NamaData, NamaDicari : string) : boolean;
{I.S. : Nama pada data dan Nama yang dicari sudah terdefenisi }
{F.S. : Menghasilkan nilai true apabila Nama yang dicari ditemukan di Nama pada data}
var
   Ketemu : boolean;
   posawal : integer;
begin
     posawal := 1;
     Ketemu := false;
     while(posawal <= (length(NamaData) - length(NamaDicari) + 1)) do
     begin
          if((upcase(NamaDicari) = upcase(copy(NamaData,posawal,length(NamaDicari))))
                                and (length(NamaDicari) <> 0)) then
          begin
               Ketemu := true;
               break;
          end
          else
              inc(posawal);
     end;
     CekString := Ketemu;
end;

function JumlahData(Awal, Akhir : Point) : integer;
{I.S. : List sudah terdefinisi }
{F.S. : Menghasilkan jumlah data yang tersimpan pada list }
var
    Jumlah : integer;
    Bantu : Point;
begin
    if(Awal = nil) then
        JumlahData := 0
    else
    begin
        if(Awal = Akhir) then
            JumlahData := 1
        else
        begin
            Bantu := Awal;
            Jumlah := 1;
            while(Bantu <> Akhir) do
            begin
                inc(Jumlah);
                Bantu := Bantu^.Next;
            end;
            JumlahData := Jumlah;
        end;
    end;
end;

procedure Penciptaan(var Awal, Akhir : Point);
{I.S. : Memberikan harga nil untuk Awal dan Akhir }
{F.S. : Menghasilkan double linklist kosong }
begin
    Awal := nil;
    Akhir := nil;
end;

procedure SisipDepan(var Awal, Akhir : Point);
{I.S. : User memasukkan data transaksi yang ingin disisipkan }
{F.S. : Menghasilkan list dengan data transaksi baru yang disisip ke depan }
var
    Baru : Point;
begin
    new(Baru);
    Baru^.Info := DataTransaksi();
    Baru^.Prev := nil;
    if(Awal = nil) then
    begin
        Baru^.Next := nil;
        Akhir := Baru;
    end
    else
    begin
        Baru^.Next := Awal;
        Awal^.Prev := Baru;
    end;
    Awal := Baru;
    gotoxy(28,15);textcolor(9);
    write('Data berhasil ditambahkan!');textcolor(7);readln;
end;

procedure SisipBelakang(var Awal, Akhir : Point);
{I.S. : User memasukkan data transaksi yang ingin disisipkan }
{F.S. : Menghasilkan list dengan data transaksi baru yang disisip ke belakang }
var
    Baru : Point;
begin
    new(Baru);
    Baru^.Info := DataTransaksi();
    Baru^.Next := nil;
    if(Awal = nil) then
    begin
        Baru^.Prev := nil;
        Awal := Baru;
    end
    else
    begin
        Baru^.Prev := Akhir;
        Akhir^.Next := Baru;
    end;
    Akhir := Baru;
    gotoxy(28,15);textcolor(9);
    write('Data berhasil ditambahkan!');textcolor(7);readln;
end;

procedure SisipTengah(var Awal, Akhir : Point);
{I.S. : User memasukkan data transaksi yang ingin disisipkan }
{F.S. : Menghasilkan list dengan data transaksi baru yang disisip ke posisi yang
 diinginkan user }
var
    Posisi, Jumlah, i : integer;
    Bantu, Baru : Point;
begin
    clrscr;
    Jumlah := JumlahData(Awal,Akhir);
    gotoxy(28,12);write('Posisi yang ingin disisip : ');readln(Posisi);
    while(Posisi < 1) or (Posisi > Jumlah) do
    begin
        gotoxy(28,14);textcolor(red);
        write('Posisi tidak ditemukan!');textcolor(7);readln;
        gotoxy(28,14);clreol;
        gotoxy(56,12);clreol;readln(Posisi);
    end;
    if(Posisi = 1) then
        SisipDepan(Awal,Akhir)
    else
    begin
        i := 1;
        Bantu := Awal;
        while(i < Posisi) do
        begin
            inc(i);
            Bantu := Bantu^.Next;
        end;
        new(Baru);
        Baru^.Info := DataTransaksi();
        Bantu^.Prev^.Next := Baru;
        Baru^.Prev := Bantu^.Prev;
        Bantu^.Prev := Baru;
        Baru^.Next := Bantu;
    end;
    gotoxy(28,15);textcolor(9);
    write('Data berhasil ditambahkan!');textcolor(7);readln;
end;

procedure HapusDepan(var Awal, Akhir : Point);
{I.S. : List telah terdefinisi }
{F.S. : Menghasilkan list dengan data transaksi pertama terhapus }
var
    Phapus : Point;
begin
    Phapus := Awal;
    if(Awal = Akhir) then
        Penciptaan(Awal,Akhir)
    else
    begin
        Awal := Awal^.Next;
        Awal^.Prev := nil;
    end;
    dispose(Phapus);
    gotoxy(33,17);textcolor(9);
    write('Data berhasil dihapus!');textcolor(7);readln;
end;

procedure HapusBelakang(var Awal, Akhir : Point);
{I.S. : List telah terdefinisi }
{F.S. : Menghasilkan list dengan data transaksi terakhir terhapus }
var
    Phapus : Point;
begin
    Phapus := Akhir;
    if(Awal = Akhir) then
        Penciptaan(Awal,Akhir)
    else
    begin
        Akhir := Akhir^.Prev;
        Akhir^.Next := nil;
    end;            
    dispose(Phapus);
    gotoxy(33,17);textcolor(9);
    write('Data berhasil dihapus!');textcolor(7);readln;
end;

procedure HapusTengah(var Awal, Akhir : Point);
{I.S. : List sudah terdefinisi }
{F.S. : Menghasilkan list dengan data transaksi dengan kode transaksi yang dipilih user terhapus }
var
    Phapus : Point;
    Kode : string;
    Ketemu : boolean;
begin
    gotoxy(33,16);
    write('Kode yang ingin dihapus : ');readln(Kode);
    Ketemu := false;
    Phapus := Awal;
    while(Phapus <> nil) and (not Ketemu) do
    begin
        if(Phapus^.Info.Kode = Kode) then
            Ketemu := true
        else
            Phapus := Phapus^.Next;
    end;
    if(Ketemu) then
    begin
        if(Phapus = Awal) then
            HapusDepan(Awal,Akhir)
        else if (Phapus = Akhir) then
            HapusBelakang(Awal,Akhir)
        else
        begin
            Phapus^.Prev^.Next := Phapus^.Next;
            Phapus^.Next^.Prev := Phapus^.Prev;
            dispose(Phapus);
            gotoxy(33,18);textcolor(9);
            write('Data dengan kode ', Kode,' berhasil dihapus!');
        end;
    end
    else
    begin
        gotoxy(33,18);textcolor(red);
        write('Data dengan kode ', Kode,' tidak ditemukan!');
    end;
    textcolor(7);readln;
end;

procedure CariKode(Awal : Point);
{I.S. : User memasukkan kode data yang ingin dicari }
{F.S. : Menampilkan data yang dicari user }
var
    Bantu : Point;
    Kode  : string;
    Ketemu : boolean;
begin
    clrscr; gotoxy(28,12);
    write('Kode yang ingin dicari : ');readln(Kode);
    Bantu := Awal;
    Ketemu := false;
    while(not Ketemu) and (Bantu <> nil) do
    begin
        if(Bantu^.Info.Kode = Kode) then
            Ketemu := true
        else
            Bantu := Bantu^.Next;
    end;
    if(Ketemu) then
    begin
        gotoxy(28,14);write('Data Transaksi dengan kode ', Kode, ' :');
        gotoxy(32,15);write('Nama Pembeli      : ', Bantu^.Info.NamaPembeli);
        gotoxy(32,16);write('Tanggal Transaksi : ', Bantu^.Info.TanggalTransaksi);
    end
    else
    begin
        gotoxy(28,14);textcolor(red);
        write('Data dengan kode ', Kode, ' tidak ditemukan!');textcolor(7);
    end;
    readln;
end;

procedure CariNama(Awal : Point);
{I.S. : User memasukkan nama yang ingin dicari }
{F.S. : Menampilkan data dengan nama yang dicari }
var
   Bantu : Point;
   Nama  : string;
   Ketemu : boolean;
   Baris : integer;
begin
    clrscr; gotoxy(28,12);
    write('Nama yang ingin dicari : ');readln(Nama);
    Bantu := Awal;
    Ketemu := false;
    while(not Ketemu) and (Bantu <> nil) do
    begin
        if(CekString(Bantu^.Info.NamaPembeli, Nama)) then
            Ketemu := true
        else
            Bantu := Bantu^.Next;
    end;

    if(Ketemu) then
    begin
        Bantu := Awal;
        clrscr;
        gotoxy(17,1);writeln('Data Transaksi');
        gotoxy(17,2);writeln('==============');
        writeln('Data dengan nama ', Nama,' :');
        writeln('-------------------------------------------------');
        writeln('| KODE |    NAMA PEMBELI    | TANGGAL TRANSAKSI |');
        writeln('-------------------------------------------------');
        Baris := 1;
        while (Bantu <> nil) do
        begin
            if(CekString(Bantu^.Info.NamaPembeli, Nama)) then
            begin
                write('|      |                    |                   |');
                gotoxy(3,6+Baris); write(Bantu^.Info.Kode);
                gotoxy(10,6+Baris); write(Bantu^.Info.NamaPembeli);
                gotoxy(31,6+Baris); writeln(Bantu^.Info.TanggalTransaksi);
                inc(Baris);
            end;
            Bantu := Bantu^.Next;
        end;
        writeln('-------------------------------------------------');
    end
    else
    begin
        clrscr;gotoxy(28,12);textcolor(red);
        write('Data dengan nama ', Nama, ' tidak ditemukan!');textcolor(7);
    end;
    readln;
end;

procedure SortKode(var Awal, Akhir : Point);
{I.S. : List telah terdefinisi }
{F.S. : Menghasilkan list yang sudah terurut secara ASC berdasarkan Kode }
var
   i, j, min : Point;
   temp      : Transaksi;
begin
    if(Awal <> nil) then
    begin
        i := Awal;
        while(i <> Akhir) do
        begin
            min := i;
            j   := i^.Next;
            while(j <> nil) do
            begin
                if(j^.Info.Kode <= min^.Info.Kode) then
                    min := j;
                j := j^.Next;
            end;
            temp := i^.Info;
            i^.Info := min^.Info;
            min^.Info := temp;
            i := i^.Next;
        end;
    end;
end;

procedure HapusDuplikat(var Awal, Akhir : Point);
{I.S. : List telah terdefinisi }
{F.S. : Menghasilkan list dengan data duplikat terhapus }
var
    Phapus, Bantu, Bantu2 : Point;
begin
    Bantu := Awal;
    while(Bantu <> nil) do
    begin
        Phapus := Bantu^.Next;
        while(Phapus <> nil) do
        begin
            if(Phapus^.Info.Kode = Bantu^.Info.Kode) then
            begin
                if(Phapus = Akhir) then
                begin
                    Phapus^.Prev^.Next := nil;
                    Akhir := Phapus^.Prev;
                end
                else
                begin
                    Phapus^.Prev^.Next := Phapus^.Next;
                    Phapus^.Next^.Prev := Phapus^.Prev;
                end;
                Bantu2 := Phapus;
                Phapus := Phapus^.Next;
                Dispose(Bantu2);
            end
            else
                Phapus := Phapus^.Next;
        end;
        Bantu := Bantu^.Next;
    end;
end;

procedure Penghancuran(var Awal, Akhir : Point);
{I.S. : List sudah terdefinisi }
{F.S. : List menjadi kosong }
var
    Phapus : Point;
begin
    Phapus := Awal;
    while(Phapus <> nil) do
    begin
         Awal := Awal^.Next;
         Dispose(Phapus);
         Phapus := Awal;
    end;
    Akhir := nil;
end;

procedure MenuAwal(var MenuUtama : integer);
{I.S. : User memilih menu yang diinginkan }
{F.S. : Menghasilkan menu yang dipilih user }
begin
    clrscr;
    gotoxy(35,8); write('MENU UTAMA');
    gotoxy(35,9);write('----------');
    gotoxy(33,10);write('1. Sisip Data');
    gotoxy(33,11);write('2. Hapus Data');
    gotoxy(33,12);write('3. Cari Data');
    gotoxy(33,13);write('4. Tampil Data');
    gotoxy(33,14);write('0. Keluar');
    gotoxy(33,15);write('Menu yang dipilih : '); readln(MenuUtama);
    ValidasiMenu(MenuUtama,0,4);
end;

procedure MenuSisip(var SubMenu : integer);
{I.S. : User memilih metode sisip yang diinginkan }
{F.S. : Melakukan penyisipan data sesuai pilihan metode user }
begin
    clrscr;
    gotoxy(35,8); write('MENU SISIP');
    gotoxy(35,9); write('----------');
    gotoxy(33,10);write('1. Sisip Depan');
    gotoxy(33,11);write('2. Sisip Tengah');
    gotoxy(33,12);write('3. Sisip Belakang');
    gotoxy(33,13);write('4. Kembali');
    gotoxy(33,15);write('Menu yang dipilih : '); readln(SubMenu);
    ValidasiMenu(SubMenu,1,4);
    case SubMenu of
        1: SisipDepan(Awal,Akhir);
        2: SisipTengah(Awal,Akhir);
        3: SisipBelakang(Awal,Akhir);
    end;
end;

procedure MenuHapus(var SubMenu : integer);
{I.S. : User memilih metode hapus yang diinginkan }
{F.S. : Melakukan penghapusan data sesuai pilihan metode user }
begin
    clrscr;
    gotoxy(35,8); write('MENU HAPUS');
    gotoxy(35,9); write('----------');
    gotoxy(33,10);write('1. Hapus Depan');
    gotoxy(33,11);write('2. Hapus Tengah');
    gotoxy(33,12);write('3. Hapus Belakang');
    gotoxy(33,13);write('4. Kembali');
    gotoxy(33,15);write('Menu yang dipilih : '); readln(SubMenu);
    ValidasiMenu(SubMenu,1,4);
    case SubMenu of
        1: HapusDepan(Awal,Akhir);
        2: HapusTengah(Awal,Akhir);
        3: HapusBelakang(Awal,Akhir);
    end;
end;

procedure MenuCari(var SubMenu : integer);
{I.S. : User memilih metode cari yang diinginkan }
{F.S. : Melakukan penghapusan data sesuai pilihan metode user }
begin
    clrscr;
    gotoxy(35,8); write('MENU CARI');
    gotoxy(35,9); write('---------');
    gotoxy(33,10);write('1. Cari Kode Transaksi');
    gotoxy(33,11);write('2. Cari Nama Pembeli');
    gotoxy(33,12);write('3. Kembali');
    gotoxy(33,15);write('Menu yang dipilih : '); readln(SubMenu);
    ValidasiMenu(SubMenu,1,4);
    case SubMenu of
        1: CariKode(Awal);
        2: CariNama(Awal);
    end;
end;

procedure TampilData(Awal : Point);
{I.S. : List sudah terdefinisi }
{F.S. : Menampilkan isi data list }
var
    Bantu : Point;
    Baris : integer;
begin
    clrscr;
    if(Awal = nil) then
    begin
        textcolor(red);gotoxy(34,12);
        write('Data kosong!');textcolor(7);
    end
    else
    begin
        SortKode(Awal,Akhir);
        HapusDuplikat(Awal,Akhir);
        Bantu := awal;
        gotoxy(17,1);writeln('Data Transaksi');  
        gotoxy(17,2);writeln('==============');
        writeln('-------------------------------------------------');
        writeln('| KODE |    NAMA PEMBELI    | TANGGAL TRANSAKSI |');
        writeln('-------------------------------------------------');
        Baris := 1;
        while (Bantu <> nil) do
        begin
            write('|      |                    |                   |');
            gotoxy(3,5+Baris); write(Bantu^.Info.Kode);
            gotoxy(10,5+Baris); write(Bantu^.Info.NamaPembeli);
            gotoxy(31,5+Baris); writeln(Bantu^.Info.TanggalTransaksi);
            inc(Baris);
            Bantu := Bantu^.Next;
        end;
        writeln('-------------------------------------------------');
    end;
    readln;
end;

// Program Utama
begin
    Penciptaan(Awal,Akhir);
    repeat
        MenuAwal(MenuUtama);
        case MenuUtama of
            1: MenuSisip(SubMenu);
            2: MenuHapus(SubMenu);
            3: MenuCari(SubMenu);
            4: TampilData(Awal);
        end;
    until(MenuUtama = 0);
    Penghancuran(Awal,Akhir);
end.

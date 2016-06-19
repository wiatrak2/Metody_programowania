{- Wojciech Pratkowiecki nr indeksu: 281417 -}
module Slownie (Rodzaj(..), Waluta(..), slownie) where
data Rodzaj = Meski | Zenski | Nijaki deriving Show

data Waluta = Waluta {
	mianownik_poj :: String,
	mianownik_mn :: String,
	dopelniacz_mn :: String,
	rodzaj :: Rodzaj
} deriving Show
{- under_1000 - funkcja zwarcająca zapis liczebników o wartości bezwględnej < 1000 z uwzględnieniem rodzaju -}
under_1000 :: Rodzaj -> Integer -> String

under_1000 r n
	| n > 99 = setki r n 
	| n > 9 = dziesatki r n
	| n > 0 = jednostki r n 
	| n == 0 = "zero"
{- zapis setek -}
setki :: Rodzaj -> Integer -> String
setki r n  = napis_set ++ napis_dec where
	napis_set =
		case n `div` 100 of
			1 -> "sto"
			2 -> "dwieście"
			3 -> "trzysta"
			4 -> "czterysta"
			5 -> "pięcset"
			6 -> "sześćset"
			7 -> "siedemset"
			8 -> "osiemset"
			9 -> "dziewięcset"
	napis_dec = (dziesatki r (n `mod` 100))
{- zapis dziesiątek -}
dziesatki :: Rodzaj -> Integer -> String
dziesatki r n = napis_dec ++ napis_jed where
	napis_dec = 
		if n < 10 then jednostki r n
		else
			if n > 19 || n == 10 then
				case n `div` 10 `mod` 10 of
					1 -> " dziesięć"
					2 -> " dwadzieścia"
					3 -> " trzydzieści"
					4 -> " czterdzieści"
					5 -> " pięćdziesiąt"
					6 -> " sześćdziesiąt"
					7 -> " siedemdziesiąt"
					8 -> " osiemdziesiąt"
					9 -> " dziewięćdziesiąt"
			else 
				case n of
					0 -> ""
					11 -> " jedenaście"
					12 -> " dwanaście"
					13 -> " trzynaście"
					14 -> " czternaście"
					15 -> " piętnaście"
					16 -> " szesnaście"
					17 -> " siedemnaście"
					18 -> " osiemnaście"
					19 -> " dziewiętnaście"
	napis_jed = 
		if n > 19 then
			(jednostki r (n `mod` 10))
		else
			[]
{- zapis jedności -}
jednostki :: Rodzaj -> Integer -> String
jednostki r n = napis_jed where
	napis_jed =
		if n == 2 then
			case r of
				Meski -> " dwa"
				Zenski -> " dwie"
				Nijaki -> " dwa"
		else
			case n `mod` 10 of
				0 -> ""
				1 -> " jeden"
				3 -> " trzy"
				4 -> " cztery"
				5 -> " pięć"
				6 -> " sześć"
				7 -> " siedem"
				8 -> " osiem"
				9 -> " dziewięć"
{- liczba o module == 1 ma jako jedyna zapis w postaci liczby pojedynczej -}
napis_jeden :: Rodzaj -> String
napis_jeden r =
	case r of
		Meski -> "jeden"
		Zenski -> "jedna"
		Nijaki -> "jedno"

{- napis_rzad - funkcja zwracająca zapis przedrostków dużych liczb zgodnie z tabelą z treści zadania -}
napis_rzad :: Integer -> Integer -> String
napis_rzad n rzad =
	if rzad == 0 then ""
	else
	if rzad == 1 then
		if n == 1 then
			" tysiąc "
		else
			if (n `mod` 10) > 1 && (n `mod` 10) < 5 && ((n `mod` 100) < 11 || (n `mod` 100) > 14) then
				" tysiące "
			else
				" tysięcy "
	else
		prefiks ++ sufiks where
			prefiks =
				if (rzad `div` 2) < 10 then	
					case rzad `div` 2 of
						1 -> " mi"
						2 -> " bi"
						3 -> " try"
						4 -> " kwadry"
						5 -> " kwinty"
						6 -> " seksty"
						7 -> " septy"
						8 -> " okty"
						9 -> " noni"
				else
					qa ++ rb ++ sc where
						qa =
							case (rzad `div` 2) `mod` 10 of
								0 -> ""
								1 -> " un"
								2 -> " do"
								3 -> " tri"
								4 -> " kwatuor"
								5 -> " kwin"
								6 -> " seks"
								7 -> " septen"
								8 -> " okto"
								9 -> " nowem"
						rb =
							 case ((rzad `div` 2) `div` 10) `mod` 10 of
								0 -> ""
								1 -> "decy"
								2 -> "wicy"
								3 -> "trycy"
								4 -> "kwadragi"
								5 -> "kwintagi"
								6 -> "seksginty"
								7 -> "septagi"
								8 -> "oktagi"
								9 -> "nonagi"
						sc = 
							case ((rzad `div` 2) `div` 100) `mod` 10 of
								0 -> ""
								1 -> "centy"
								2 -> "ducenty"
								3 -> "trycenty"
								4 -> "kwadryge"
								5 -> "kwinge"
								6 -> "sescenty"
								7 -> "septynge"
								8 -> "oktynge"
								9 -> "nonge"
			sufiks =
				if rzad `mod` 2 == 0 then
					if n == 1 then
					 "lion "
					else
						if (n `mod` 10) > 1 && (n `mod` 10) < 5 && ((n `mod` 100) < 11 || (n `mod` 100) > 14) then
							"liony "
						else
							"lionów "
				else
					if n == 1 then
					 "liard "
					else
						if (n `mod` 10) > 1 && (n `mod` 10) < 5 && ((n `mod` 100) < 11 || (n `mod` 100) > 14) then
							"liardy "
						else
							"liardów "
{- funkcja zwracająca zapis liczb o module > 1 -}
napis_num :: Rodzaj -> Integer -> Integer -> String
napis_num rod n rzad = 
	if n < 1000 then
		if rzad > 0 then
			(under_1000 Meski n) ++ (napis_rzad n rzad) {- "dwa tysiące kun" a nie "dwie tysiące kun" -}
		else
			(under_1000 rod n) ++ (napis_rzad n rzad)
	else
		rest ++ result where
			result = 
				if (n `mod` 1000) > 0 && rzad > 0 then
					(under_1000 Meski (n `mod` 1000)) ++ (napis_rzad (n `mod` 1000) rzad)
				else if (n `mod` 1000) > 0 && rzad == 0 then
					(under_1000 rod (n `mod` 1000)) ++ (napis_rzad (n `mod` 1000) rzad)
				else
					""
			rest = napis_num rod (n `div` 1000) (rzad + 1)

{- funkcja zwracająca zapis słowny każdej liczby o module mniejszym niż 10^6000 -}
slownie_liczba :: Rodzaj -> Integer -> String
slownie_liczba rod n 
	| n < 0 = ujemna rod n
	| n == 1 = napis_jeden rod
	| otherwise = napis_num rod n 0
{- dodanie "minus" dla liczb ujemnych -}
ujemna :: Rodzaj -> Integer -> String
ujemna r n = "minus " ++ napis_odwr where
	napis_odwr = (slownie_liczba r (-n))

{- funcka zwracająca zapis słowny waluty dla odpowiedniego liczebnika -}
slownie_waluta :: Waluta -> Integer -> String
slownie_waluta waluta n = 
	if n == 1  || n == (-1) then 
		get_mp $ waluta
	else
		if ((abs n) `mod` 10) > 1 && ((abs) n `mod` 10) < 5 && (((abs) n `mod` 100) < 11 || ((abs) n `mod` 100) > 14) then
			get_mm $ waluta
		else
			get_dm $ waluta 
{- wydobywanie pól typu Waluta -}
get_mp :: Waluta -> String
get_mp (Waluta mp _ _ _) = mp

get_mm :: Waluta -> String
get_mm (Waluta _ mm _ _) = mm

get_dm :: Waluta -> String
get_dm (Waluta _ _ dm _) = dm

get_r :: Waluta -> Rodzaj
get_r (Waluta _ _ _ r) = r
{- klasa Monoid1 (zaprezentowana na zajęciach związanych z listą 10) do sprawnego obliczenia 10^6000 - limitu nazywania liczebników -}
class Monoid1 a where
    (***) :: a -> a -> a
    e :: a
infixl 6 ***

infixr 7 ^^^
(^^^) :: Monoid1 a => a -> Integer -> a
a ^^^ 0 = e
a ^^^ n
    |odd n = a *** k *** k  
    |otherwise = k *** k
        where k = a ^^^ (n `div` 2)

instance Monoid1 Integer where
    (***)  = (*) 
    e = 1

get_big_num :: Integer -> Integer ->Integer
get_big_num n m  = n ^^^ m
{- koniec Monoid1 -}
{- removeSpace - usuwa ewentualną spację na początku wynikowego napisu -}
removeSpace (' ' : xs) = xs
removeSpace xs = xs
{- removeSpace' - usuwa wszystkie ciągi spacji o długości >= 2 -}
removeSpace' :: [Char] -> [Char]
removeSpace' [] =[] 
removeSpace' (' ' : ' ' : xs) = removeSpace' (' ' : xs)
removeSpace' (x : xs) = (x : removeSpace' xs)
{- slownie - wywołuje funkcję slownie' ale usuwa ewentualną spację na początku -}
slownie :: Waluta -> Integer -> String
slownie waluta n = removeSpace $ slownie' waluta n
{- slownie' - główna funkcja, tworzy napis w postaci liczebik ++ waluta usuwając zbędne spacje -}
slownie' :: Waluta -> Integer -> String
slownie' waluta n = removeSpace' napis_slownie where
	napis_slownie = 
		if n >= get_big_num 10 6000 || (-n) >= get_big_num 10 6000 then
			 "mnóstwo"
		else
			(slownie_liczba rodzaj n) ++ " " ++ (slownie_waluta waluta n) where
				rodzaj = get_r waluta


{- Wojciech Pratkowiecki nr indeksu: 281417 -}
import Slownie
import qualified System.Environment as SE

aud = Waluta "dolar australijski" "dolary australijskie" "dolarów australijskich" Meski
bgn = Waluta "lew bułgarski" "lewy bułgarskie" "lewów bułgarskich" Meski
brl = Waluta "real" "reale" "realów" Meski
byr = Waluta "rubel białoruski" "ruble białoruskie" "rubli białoruskich" Meski
cad = Waluta "dolar kanadyjski" "dolary kanadyjskie" "dolarów kanadyjskich" Meski
chf = Waluta "frank szwajcarski" "franki szwajcarskie" "franków szwajcarskich" Meski
cny = Waluta "juan" "juany" "juanów" Meski
czk = Waluta "korona czeska" "korony czeskie" "koron czeskich" Zenski
dkk = Waluta "korona duńska" "korony duńskie" "koron duńskich" Zenski
eur = Waluta "euro" "euro" "euro" Nijaki
gbp = Waluta "funt brytysjki" "funty brytyjskie" "funtów brytyjkich" Meski
hkd = Waluta "dolar hongkoński" "dolary hongkońskie" "dolarów hongkońskich" Meski
hrk = Waluta "kuna chorwacka" "kuny chorwackie" "kun chorwackich" Zenski
huf = Waluta "forin węgierski" "foriny węgierskie" "forinów węgierskich" Meski
idr = Waluta "rupia" "rupie" "rupii" Zenski
isk = Waluta "korona islandzka" "korony islandzkie" "koron islandzkich" Zenski
jpy = Waluta "jen japoński" "jeny japońskie" "jenów japońskich" Meski
krw = Waluta "won" "wony" "wonów" Meski
mxn = Waluta "peso" "peso" "peso" Nijaki
myr = Waluta "ringgit malezyjski" "riggity malezyjskie" "ringgitów malezyjskich" Meski
nok = Waluta "korona norweska" "korony norweskie" "koron norweskich" Zenski
nzd = Waluta "dolar nowozelandzki" "dolary nowozelandzkie" "dolarów nowozelandzkich" Meski
php = Waluta "peso filipińskie" "peso filipińskie" "peso filipińskich" Nijaki
pln = Waluta "złoty" "złote" "złotych" Meski
ron = Waluta "lej rumuński" "leje rumuńskie" "lejów rumuńskich" Meski
rub = Waluta "rubel rosyjski" "ruble rosyjskie" "rubli rosyjskich" Meski
sdr = Waluta "specjalne prawo ciągnienia" "specjalne prawa ciągnienia" "specjalnych praw ciągnienia" Nijaki
sek = Waluta "korona szwedzka" "korony szwedzkie" "koron szwedzkich" Zenski
sgd = Waluta "dolar singapurski" "dolary singapurskie" "dolarów singapurskich" Meski
thb = Waluta "baht" "bahty" "bahtów" Meski
try = Waluta "lira turecka" "liry tureckie" "lir tureckich" Zenski
uah = Waluta "hrywna" "hrywny" "hrywien" Zenski
usd = Waluta "dolar amerykański" "dolary amerykańskie" "dolarów amerykańskich" Meski
zar = Waluta "rand" "randy" "randów" Meski

get_waluta :: String -> Waluta
get_waluta nazwa =
	case nazwa of
		"AUD" -> aud
		"BGN" -> bgn
		"BRL" -> brl
		"BYR" -> byr
		"CAD" -> cad
		"CHF" -> chf
		"CNY" -> cny
		"CZK" -> czk
		"DKK" -> dkk
		"EUR" -> eur
		"GBP" -> gbp
		"HKD" -> hkd
		"HRK" -> hrk
		"HUF" -> huf
		"IDR" -> idr
		"ISK" -> isk
		"JPY" -> jpy
		"KRW" -> krw
		"MXN" -> mxn
		"MYR" -> myr
		"NOK" -> nok
		"NZD" -> nzd
		"PHP" -> php
		"PLN" -> pln
		"RON" -> ron
		"RUB" -> rub
		"SDR" -> sdr
		"SEK" -> sek
		"SGD" -> sgd
		"THB" -> thb
		"TRY" -> try
		"UAH" -> uah
		"USD" -> usd
		"ZAR" -> zar

main = do 
	(n : waluta : _) <- SE.getArgs
	putStrLn $ Slownie.slownie (get_waluta waluta) (read n)




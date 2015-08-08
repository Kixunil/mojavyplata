#!/usr/bin/awk -f
BEGIN { 
	print "<?xml version=\"1.0\" encoding=\"UTF_8\"?>"
	print "<payroll_list>" 
	print "<payroll>" 
	}
	/programom HUMAN/{
			print "</payroll>"
			print "<payroll>"
		}
	/VZ ZP/{printf "<vz_zdravotne_poistenie>%s</vz_zdravotne_poistenie>\n",$3}
	/VZ NP/{printf "<vz_nemocenske_poistenie>%s</vz_nemocenske_poistenie>\n",$3}
	/VZ PvN/{printf "<vz_poistenie_v_nezamestnanosti>%s</vz_poistenie_v_nezamestnanosti>\n",$3}
	/VZ DPi/{printf "<vz_dochodkove_invalidne_poistenie>%s</vz_dochodkove_invalidne_poistenie>\n",$3}
	/VZ DPs/{printf "<vz_dochodkove_starobne_poistenie>%s</vz_dochodkove_starobne_poistenie>\n",$3}

	/Da.ov/{printf "<nezdanitelna_ciastka>%s</nezdanitelna_ciastka>\n",$3}
	/DDS/{printf "<dds>%s</dds>\n<zp>%s</zp>\n",substr($3,0,index($3,"/")-1),substr($3,index($3,"/")+1)}
	/Auto/{printf "<dan_auto>%s</dan_auto>\n",$3}
	/In/{printf "<dan_in>%s</dan_in>\n",$3}

	/Os. ..slo:/{printf "<osobne_cislo>%s</osobne_cislo>\n",$3}
	/Stredisko:/{
			printf "<stredisko>%s</stredisko>\n",$2
			getline
			printf "<meno>%s</meno>\n",$0
			getline
			printf "<datum>%s</datum>\n",$0
			getline
			printf "<spolocnost>%s</spolocnost>\n",$0
		}
	/Druh PP/{printf "<druh_pracovneho_pomeru>%s</druh_pracovneho_pomeru>\n",$3}

	/D-n.rok/{printf "<dovolenka_narok>%s</dovolenka_narok>\n",$2}
	/D-min/{printf "<dovolenka_prenesena>%s</dovolenka_prenesena>\n",$2}
	/D-dodat/{printf "<dovolenka_benefit>%s</dovolenka_benefit>\n",$2}
	/D-.erpan./{printf "<dovolenka_cerpana>%s</dovolenka_cerpana>\n",$2}
	/D-zostat/{printf "<dovolenka_zostatok>%s</dovolenka_zostatok>\n",$2}
	/D-sk.zos./{printf "<dovolenka_skutocny_zostatok>%s</dovolenka_skutocny_zostatok>\n",$2}


	/^ZP /{printf "<zdravotna_poistovna>%s %s</zdravotna_poistovna>\n",$2,$3}
	/Z.kl\.plat/{printf "<zakladny_plat>%s</zakladny_plat>\n",$2}
	/Tarif\.trieda/{printf "<tarifna_trieda>%s</tarifna_trieda>\n",$2}
	/Tarif\.stupe./{printf "<tarifny_stupen>%s</tarifny_stupen>\n",$2}
	/Priem\. nah\./{printf "<priem_nah>%s</priem_nah>\n",$3}
	/DVZ n.hr\./{printf "<denny_vymeriavaci_zaklad>%s</denny_vymeriavaci_zaklad>\n",$3}
	/^.v.zok /{
		if($3 == "%")
			printf "<uvazok>%s</uvazok>\n<uvazok_hodiny_za_tyzden>%s</uvazok_hodiny_za_tyzden>\n",$2,$4;
		else
			printf "<uvazok>%s</uvazok>\n<uvazok_hodiny_za_tyzden>%s</uvazok_hodiny_za_tyzden>\n<uvazok_hodiny_za_den>%s</uvazok_hodiny_za_den>\n",$2,substr($3,3),$5;
	}
	/Po.et odprac\. dn./{ printf "<odpracovane_dni>%s</odpracovane_dni>\n",$4}
	
	/Po.et dn. sviatkov/{printf "<sviatky>%s</sviatky>\n",$4}

	/Po.et odprac\. hod.n/{printf "<odpracovane_hodiny>%s</odpracovane_hodiny>\n",$4}
	/Po.et hod.n sviatkov/{printf "<odpracovane_hodiny_sviatky>%s</odpracovane_hodiny_sviatky>\n",$4}

	/z.kladn. plat tarifn./{printf "<zakladny_plat_tarifny>%s</zakladny_plat_tarifny>\n",$5}
	/HRUB. MZDA/{printf "<hruba_mzda>%s</hruba_mzda>\n",$3}
	/Zdanite.n. pr.jem/{printf "<zdanitelny_prijem>%s</zdanitelny_prijem>\n",$4}
	/HRUB. PR.JEM/{printf "<hruby_prijem>%s</hruby_prijem>\n",$3}

	/ZP-zamestnanec/{printf "<zampoist_zdravotne>%s</zampoist_zdravotne>\n",$4}
	/NP-zamestnanec/{printf "<zampoist_nemocenske>%s</zampoist_nemocenske>\n",$4}
	/DP-zamestnanec/{printf "<zampoist_starobne>%s</zampoist_starobne>\n",$4}
	/DPI-zamestnanec/{printf "<zampoist_invalidne>%s</zampoist_invalidne>\n",$3}
	/PvN-zamestnanec/{printf "<zampoist_v_nezamestnanosti>%s</zampoist_v_nezamestnanosti>\n",$4}
	/Da. zo mzdy -preddavok/{printf "<dan_preddavok>%s</dan_preddavok>\n",$6}
	/.IST. MZDA/{printf "<cista_mzda>%s</cista_mzda>\n",$3}
	/.IST. PR.JEM/{printf "<cisty_prijem>%s</cisty_prijem>\n",$3}
	/^O?bedy/{printf "<obedy>%s</obedy>\n",$3}
	/CELKOV. CENA PR.CE/{printf "<celkova_cena_prace>%s</celkova_cena_prace>\n",$4}

	/- d.ch\.poist\.starobn./{ printf "<doch_poist_starobne>%s</doch_poist_starobne>\n",$3}
	/^d.ch\.poist\.starobn./{ printf "<doch_poist_starobne>%s</doch_poist_starobne>\n",$2}

	/^- d.ch\.poist\.invalidn./{ printf "<doch_poist_invalidne>%s</doch_poist_invalidne>\n",$3}
	/^d.ch\.poist\.invalidn./{ printf "<doch_poist_invalidne>%s</doch_poist_invalidne>\n",$2}

	/^- garan.n. poistenie/{ printf "<garancne_poistenie>%s</garancne_poistenie>\n",$4}
	/^garan.n. poistenie/{ printf "<garancne_poistenie>%s</garancne_poistenie>\n",$3}

	/^- pr.spevok do RFS/{ printf "<prispevok_do_rfs>%s</prispevok_do_rfs>\n",$5}
	/^pr.spevok do RFS/{ printf "<prispevok_do_rfs>%s</prispevok_do_rfs>\n",$4}

	/^- .razov. poistenie/{ printf "<urazove_poistenie>%s</urazove_poistenie>\n",$4}
	/^.razov. poistenie/{ printf "<urazove_poistenie>%s</urazove_poistenie>\n",$3}

	/^- zdravotn. poistenie/{printf "<zdravotne_poistenie>%s</zdravotne_poistenie>\n",$4}
	/^zdravotn. poistenie/{printf "<zdravotne_poistenie>%s</zdravotne_poistenie>\n",$3}

	/^- nemocensk. poist\./{ printf "<nemocenske_poistenie>%s</nemocenske_poistenie>\n",$3}
	/^nemocensk. poist\./{ printf "<nemocenske_poistenie>%s</nemocenske_poistenie>\n",$3}

	/^Osobn. ohodnotenie/{ printf "<osobne_ohodnotenie>%s</osobne_ohodnotenie>\n",$4}
	/^n.hr.za n.v.tevu lek.r/{ printf "<nahrada_za_navstevu_lekara>%s</nahrada_za_navstevu_lekara>\n",$5}

	/^- z toho 2\. pilier/{ printf "<druhy_pilier>%s</druhy_pilier>\n",$6}
	/^z toho 2\. pilier/{ printf "<druhy_pilier>%s</druhy_pilier>\n",$5}

END { 
	print "</payroll>" 
	print "</payroll_list>" 
	}

from django.shortcuts import render_to_response
from django.template import RequestContext
from xml.etree import ElementTree
import xmltodict
from easy_pdf.views import PDFTemplateView

def home_page(request, template='home/index.html'):

	return render_to_response(template,context_instance=RequestContext(request))



class HelloPDFView(PDFTemplateView):
    template_name = "doc_handler/Styled.html"

    def get_context_data(self, **kwargs):
        return super(HelloPDFView, self).get_context_data(
            pagesize="A4",
            title="Hi there!",
            **kwargs
        )

def xml_handler(request, template='doc_handler/payroll_styled.html'):

	data = {}

	if 'xmlfile' in request.FILES:
		XMLfiles = request.FILES['xmlfile']
	else:
		XMLfiles = False
	

	with XMLfiles as fd:
		data = xmltodict.parse(fd.read())

	for company in data['payroll_list']['payroll']:
		if not company is None:
			try: 
				company['zdravotne_poistenie']
			except KeyError:
				company['zdravotne_poistenie'] = 0
			try: 
				company['zampoist_zdravotne']
			except KeyError:
				company['zampoist_zdravotne'] = 0
			try: 
				company['nemocenske_poistenie']
			except KeyError:
				company['nemocenske_poistenie'] = 0
			try: 
				company['zampoist_nemocenske']
			except KeyError:
				company['zampoist_nemocenske'] = 0
			try: 
				company['doch_poist_starobne']
			except KeyError:
				company['doch_poist_starobne'] = 0
			try: 
				company['zampoist_starobne']
			except KeyError:
				company['zampoist_starobne'] = 0
			try: 
				company['doch_poist_invalidne']
			except KeyError:
				company['doch_poist_invalidne'] = 0
			try: 
				company['zampoist_invalidne']
			except KeyError:
				company['zampoist_invalidne'] = 0
			try: 
				company['poistenie_v_nezamestnanosti']
			except KeyError:
				company['poistenie_v_nezamestnanosti'] = 0
			try: 
				company['zampoist_v_nezamestnanosti']
			except KeyError:
				company['zampoist_v_nezamestnanosti'] = 0
			try: 
				company['cista_mzda']
			except KeyError:
				company['cista_mzda'] = 1
			try: 
				company['celkova_cena_prace']
			except KeyError:
				company['celkova_cena_prace'] = 1
			try: 
				company['garancne_poistenie']
			except KeyError:
				company['garancne_poistenie'] = 0
			try: 
				company['prispevok_do_rfs']
			except KeyError:
				company['prispevok_do_rfs'] = 0
			try: 
				company['urazove_poistenie']
			except KeyError:
				company['urazove_poistenie'] = 0
			try: 
				company['dan_preddavok']
			except KeyError:
				company['dan_preddavok'] = 0
			try: 
				company['obedy']
			except KeyError:
				company['obedy'] = 0

			company['cista_mzda_final'] = float(company['cista_mzda']) - float(company['obedy'])
			company['zdrav_poist_sum'] = float(company['zdravotne_poistenie']) + float(company['zampoist_zdravotne'])
			company['nemocenske_poist_sum'] = float(company['nemocenske_poistenie']) + float(company['zampoist_nemocenske'])
			company['starobne_poist_sum'] = float(company['doch_poist_starobne']) + float(company['zampoist_starobne'])
			company['invalidne_poist_sum'] = float(company['doch_poist_invalidne']) + float(company['zampoist_invalidne'])
			company['nezam_poist_sum'] = float(company['poistenie_v_nezamestnanosti']) + float(company['zampoist_v_nezamestnanosti'])
			
			company['percento_cista'] = int(round(float(company['cisty_prijem']) / float(company['celkova_cena_prace']) * 100,0))
			company['percento_daneodvody'] = 100 - company['percento_cista']
			company['do_zdravotnej_sum'] = float(company['zdravotne_poistenie'])
			company['do_socialnej_sum'] = float(company['starobne_poist_sum']) + float(company['invalidne_poist_sum']) + float(company['nezam_poist_sum']) + float(company['garancne_poistenie']) + float(company['prispevok_do_rfs']) + float(company['nemocenske_poist_sum']) + float(company['urazove_poistenie'])
			company['zostatkova_dovolenka'] = float(company['dovolenka_narok']) + float(company['dovolenka_prenesena']) + float(company['dovolenka_benefit']) - float(company['dovolenka_cerpana'])
			company['dane_a_odvody_sum'] = float(company['do_zdravotnej_sum']) + float(company['do_socialnej_sum']) + float(company['dan_preddavok'])
		else:
			pass

	rangee = 2

	return render_to_response(template, {'data':data, 'rangee':rangee},context_instance=RequestContext(request))
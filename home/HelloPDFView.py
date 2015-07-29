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
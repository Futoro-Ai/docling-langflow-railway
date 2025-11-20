import sys
import logging
from docling.document_converter import DocumentConverter

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def test_docling_parsing(source):
    """
    Smoke test for Docling parsing.
    """
    try:
        logger.info(f"Attempting to parse: {source}")
        converter = DocumentConverter()
        result = converter.convert(source)
        
        logger.info("Parsing successful!")
        logger.info("Document content snippet:")
        # Print first 500 characters of the markdown output
        print(result.document.export_to_markdown()[:500])
        
        return True
    except Exception as e:
        logger.error(f"Parsing failed: {e}")
        return False

if __name__ == "__main__":
    # Use a default public PDF URL if no argument is provided
    # This one is a simple sample from W3C
    DEFAULT_PDF_URL = "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf"
    
    source = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_PDF_URL
    
    success = test_docling_parsing(source)
    
    if success:
        sys.exit(0)
    else:
        sys.exit(1)

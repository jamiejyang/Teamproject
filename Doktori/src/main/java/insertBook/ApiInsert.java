package insertBook;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.net.URL;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import dao.LibDAO;
import dto.LibDTO;

public class ApiInsert {



	public static void main(String[] args) {
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();

			try {
				LibDTO dto = new LibDTO();
				String bookNum = dto.getBookNum();
				//오류 시 해결 ㄱㄱ 
				
				DocumentBuilder builder = factory.newDocumentBuilder();
				StringBuffer pharm_url = new StringBuffer();
				pharm_url.append("http://openapi-lib.sen.go.kr/openapi/service/lib/openApi");
				pharm_url.append(
						"?serviceKey=0OhBU7ZCGIobDVKDeBJDpmDRqK3IRNF6jlf%2FJB2diFAf%2FfR2czYO9A4UTGcsOwppV6W2HVUeho%2FFPwXoL6DwqA%3D%3D&pageNo=1&numOfRows=100&manageCd=M"
								+ "A");

				URL url = new URL(pharm_url.toString());

				BufferedInputStream xmldata = new BufferedInputStream(url.openStream());

				Document document = builder.parse(xmldata);
				Element root = document.getDocumentElement();
				System.out.println(root.getTagName());
				NodeList list = root.getElementsByTagName("item");
				System.out.println(list.getLength());
				for (int i = 0; i < list.getLength(); i++) {
					Node node = list.item(i);
					NodeList item_childlist = node.getChildNodes();
					for (int j = 0; j < item_childlist.getLength(); j++) {
						Node item_child = item_childlist.item(j);
						System.out.println(item_child.getNodeName() + " : " + item_child.getTextContent());
					}
					System.out.println();

					LibDAO ldao = new LibDAO();
					ldao.insertLib(new LibDTO(item_childlist.item(2).getTextContent(),
							item_childlist.item(13).getTextContent(), item_childlist.item(6).getTextContent(),
							item_childlist.item(7).getTextContent(), item_childlist.item(10).getTextContent(),
							item_childlist.item(4).getTextContent(), item_childlist.item(3).getTextContent(),
							item_childlist.item(12).getTextContent(), item_childlist.item(14).getTextContent(),
							item_childlist.item(1).getTextContent(), item_childlist.item(9).getTextContent(),
							item_childlist.item(8).getTextContent(), item_childlist.item(5).getTextContent(), bookNum));

				}

			} catch (ParserConfigurationException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} catch (SAXException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
	}
}

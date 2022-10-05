package dto;

public class FaqDTO {
	private String qu;
	private String an;
	private String num;
	
	public FaqDTO() {
		
	}
	
	public FaqDTO(String qu, String an) {
		this.qu = qu;
		this.an = an;
	}
	
	public String getNum() {
		return num;
	}
	
	public void setNum(String num) {
		this.num = num;
	}

	public String getQu() {
		return qu;
	}

	public void setQu(String qu) {
		this.qu = qu;
	}

	public String getAn() {
		return an;
	}

	public void setAn(String an) {
		this.an = an;
	}
	
}

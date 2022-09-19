package membership;

public class MemberDTO {

	private String name;
	private String nickname;
	private String id;
	private String pass;
	
	public MemberDTO() {
		
	}
	
	public MemberDTO(String name, String nickname, String id, String pass) {
		this.name = name;
		this.nickname = nickname;
		this.id = id;
		this.pass = pass;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

}

package persistence;

import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailHelper {

	private static EmailHelper emailHelper;

	private EmailHelper() {

	}

	public static EmailHelper getInstance() {
		if (emailHelper == null) {
			emailHelper = new EmailHelper();
		}
		return emailHelper;
	}

	public String sendAndGetCode(String to_email) {

		String host = "smtp.naver.com";
		String user = "cdecde2004@naver.com"; // 자신의 네이버 계정
		String password = "Almond!2134";// 자신의 네이버 패스워드
		String AuthenticationKey = "";
		// String to_email = "rbgks2222@naver.com";

		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 465);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");

		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		for (int i = 0; i < 10; i++) {
			int rIndex = rnd.nextInt(3);
			switch (rIndex) {
			case 0:

				temp.append((char) ((int) (rnd.nextInt(26)) + 97));
				break;
			case 1:

				temp.append((char) ((int) (rnd.nextInt(26)) + 65));
				break;
			case 2:

				temp.append((rnd.nextInt(10)));
				break;
			}
		}

		AuthenticationKey = temp.toString();
		System.out.println(AuthenticationKey);

		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});

		try {
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(user, "4운드 클라우드"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to_email));

			msg.setSubject("4운드 클라우드 인증 메일입니다.");

			msg.setText("인증 번호는 : " + temp);

			Transport.send(msg);
			System.out.println("이메일 전송");

		} catch (Exception e) {

			e.printStackTrace();

		}
		return AuthenticationKey;
	} // sendCode end

}

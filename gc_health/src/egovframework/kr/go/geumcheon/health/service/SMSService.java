package egovframework.kr.go.geumcheon.health.service;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.EOFException;
import java.io.IOException;
import java.io.InterruptedIOException;
import java.net.Socket;

import org.springframework.stereotype.Service;

@Service("SMSService")
public class SMSService {
	protected Socket socket;
	int port = 7296;

	String destination = "118.220.42.7";
	DataOutputStream out;
	DataInputStream in;
	private String ID = "보건통보";
	private String PW = "a12345";

	public void connect() throws Exception {
		socket = new Socket(destination, port);
		socket.setSoTimeout(5000);
		out = new DataOutputStream(socket.getOutputStream());
		in = new DataInputStream(socket.getInputStream());
	}

	public void disconnect() throws Exception {
		in.close();
		out.close();
		socket.close();
	}

	// 전화번호와 회신번호는 숫자만가능
	// return string 은 하기와 같습니다.
	// "00" : 성공
	// "02" : 로그인 실패
	// "98" : (주)아이하트의 서버에서 SMSC 정보 저장 중 문제가 발생
	// "99" : 잘못된 형식의 SMS 정보가 전달됨
	public String SendMsg(String callNo, String callBack, String caller,
			String msg) throws IOException {
		String result = "", msgid = "";
		int i = 0;
		out.writeBytes("01"); // Msg Type
		out.writeBytes("144 "); // Msg Len
		out.writeBytes(fillSpace(ID, 10));
		out.writeBytes(fillSpace(PW, 10));
		out.writeBytes(fillSpace(callNo, 11));
		out.writeBytes(fillSpace(callBack, 11));
		out.writeBytes(fillSpace(caller, 10));
		out.writeBytes(fillSpace(" ", 12)); // 즉시전송시 날짜와 시간은 모두 space
		// 예약 전송시 12자리를 맞춰주시면 됩니다. 형식은 YYYYMMDDHH
		out.writeBytes(fillSpace(msg, 80)); // msg
		out.flush();

		boolean inputExist = true;

		do {
			try {
				byte buffer[] = new byte[2];
				for (i = 0; i < 2; i++)
					buffer[i] = in.readByte();
				String msgType = new String(buffer);
				byte temp[] = new byte[4];
				for (i = 0; i < 4; i++)
					temp[i] = in.readByte();
				String sLen = new String(temp);
				sLen = sLen.trim();

				int nLen = Integer.valueOf(sLen).intValue();
				buffer = new byte[nLen];

				if (msgType.equals("02")) {
					inputExist = false;

					for (i = 0; i < nLen; i++)
						buffer[i] = in.readByte();
					result = new String(buffer);

					msgid = result.substring(0, 2);
				} else {
					inputExist = false;
					msgid = "98";
				}

			} catch (EOFException e) {
				inputExist = false;

			} catch (InterruptedIOException e) {
				inputExist = false;
			}
		} while (inputExist);

		return msgid.trim();
	}

	private String fillSpace(String text, int size) {
		int diff = size - text.length();
		if (diff > 0) {
			for (int i = 0; i < diff; i++)
				text += " ";
		} else {
			StringBuffer sb = new StringBuffer(text);
			sb.setLength(size);
			text = sb.toString();
		}

		return text;
	}

	public static void main(String[] args){
		SMSService service = null;
		try
		{
		service = new SMSService();
		service.connect();
		service.SendMsg("0172320856", "0172320856", "test",
				"테스트메세지");
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try
			{
				service.disconnect();
			}catch(Exception e)
			{
			}
		}
	}
}

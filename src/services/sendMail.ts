import transporter from "../modules/mailTransporter";
interface sendMailProps {
  from: string
  to: string
  subject: string
  text: string
  html: string
}

const sendMail = async ({from, to, subject, text, html}: sendMailProps) => {
  await transporter.sendMail({ from, to, subject, text, html });
}


export default sendMail;
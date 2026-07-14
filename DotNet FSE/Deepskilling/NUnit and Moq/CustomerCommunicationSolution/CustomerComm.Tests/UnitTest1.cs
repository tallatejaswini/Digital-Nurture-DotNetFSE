using CustomerCommLib;
using Moq;
using NUnit.Framework;

namespace CustomerComm.Tests
{
    [TestFixture]
    public class UnitTest1
    {
        private Mock<IMailSender> mockMailSender;

        // Notice CustomerCommLib.CustomerComm
        private CustomerCommLib.CustomerComm customerComm;

        [OneTimeSetUp]
        public void Init()
        {
            mockMailSender = new Mock<IMailSender>();

            mockMailSender
                .Setup(x => x.SendMail(It.IsAny<string>(), It.IsAny<string>()))
                .Returns(true);

            customerComm = new CustomerCommLib.CustomerComm(mockMailSender.Object);
        }

        [Test]
        public void Test_SendMailToCustomer_ReturnsTrue()
        {
            bool result = customerComm.SendMailToCustomer();

            Assert.That(result, Is.True);
        }
    }
}
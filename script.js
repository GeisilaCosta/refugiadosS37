window.onload = function () {
    emailjs.init("3t_K6GvSa5r8242g7"); // Inicializa EmailJS

    let form = document.getElementById("contactForm");

    if (!form) {
        console.error("Erro: Formulário não encontrado!");
        return;
    }

    form.addEventListener("submit", function (event) {
        event.preventDefault();

        emailjs.sendForm("service_fkc1i6a", "template_c4mc5up", form)
            .then(function (response) {
                let statusMsg = document.getElementById("status-message");
                if (statusMsg) {
                    statusMsg.textContent = "E-mail enviado com sucesso!";
                    statusMsg.style.color = "black";
                }
                console.log("E-mail enviado:", response);
                
                // Limpa os campos do formulário após o envio
                form.reset();

            }, function (error) {
                let statusMsg = document.getElementById("status-message");
                if (statusMsg) {
                    statusMsg.textContent = "Erro ao enviar o e-mail. Tente novamente mais tarde.";
                    statusMsg.style.color = "red";
                }
                console.error("Erro ao enviar:", error);
            });
    });
};


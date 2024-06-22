<#import "template.ftl" as layout>
<#import "components/button/primary.ftl" as buttonPrimary>
<#import "components/input/primary.ftl" as inputPrimary>
<#import "components/link/secondary.ftl" as linkSecondary>
<#import "template.ftl" as layout>
<#import "components/provider.ftl" as provider>
<#import "components/button/primary.ftl" as buttonPrimary>
<#import "components/checkbox/primary.ftl" as checkboxPrimary>
<#import "components/input/primary.ftl" as inputPrimary>
<#import "components/label/username.ftl" as labelUsername>
<#import "components/link/primary.ftl" as linkPrimary>
<@layout.registrationLayout
  displayMessage=!messagesPerField.existsError("firstName", "lastName", "email", "username", "password", "password-confirm")
  ;
  section
>
  <#if section="header">
    ${msg("registerTitle")}
  <#elseif section="form">
    <style>
      #emailError {
        display: none;
      }
      #submitButton {
        opacity: 0.5; /* Opacité réduite lorsque le bouton est désactivé */
        cursor: not-allowed; /* Curseur non disponible lorsque le bouton est désactivé */
      }

      #submitButton:enabled {
        opacity: 1; /* Opacité normale lorsque le bouton est activé */
        cursor: pointer; /* Curseur normal lorsque le bouton est activé */
      }
    </style>
    <form action="${url.registrationAction}" class="m-0 space-y-4" method="post" >
      <div>
        <@inputPrimary.kw
          autocomplete="given-name"
          autofocus=true
          invalid=["firstName"]
          name="firstName"
          type="text"
          value=(register.formData.firstName)!''
        >
          ${msg("firstName")}
        </@inputPrimary.kw>
      </div>
      <div>
        <@inputPrimary.kw
          autocomplete="family-name"
          invalid=["lastName"]
          name="lastName"
          type="text"
          value=(register.formData.lastName)!''
        >
          ${msg("lastName")}
        </@inputPrimary.kw>
      </div>
      <div>
        <@inputPrimary.kw
          autocomplete="email"
          invalid=["email"]
          name="email"
          type="email"
          value=(register.formData.email)!''
        >
          ${msg("email")}
        </@inputPrimary.kw>
        <div id="emailError" class="alert alert-danger" style="color: red; display: none;"></div>

      </div>
      <#if !realm.registrationEmailAsUsername>
        <div>
          <@inputPrimary.kw
          autocomplete="username"
          invalid=["username"]
          name="username"
          type="text"
          value=(register.formData.username)!''
          oninput="validateUsername(this.value)"
          >
            ${msg("username")}
          </@inputPrimary.kw>
          <div id="usernameError" class="alert alert-danger" style="color: red; display: none;"></div>
        </div>
      </#if>
<div>
      <select id="countryCode" class="border-gray-300 h-10 rounded text-primary-600 w-100 focus:ring-primary-200 focus:ring-opacity-50">
        <option value="+216">🇹🇳 Tunisia (+216)</option>
        <option value="+33">🇫🇷 France (+33)</option>
        <option value="+49">🇩🇪 Germany (+49)</option>
        <option value="+1">🇺🇸 United States (+1)</option>
      </select>
</div>
      <div>
        <input
                type="tel"
                id="phoneNumber"
                name="user.attributes.mobile"
                autocomplete="tel"
                invalid="mobile"
                placeholder="Numéro de téléphone"
                class="border-gray-300 h-10 rounded text-primary-600 w-full focus:ring-primary-200 focus:ring-opacity-50"
        />
      </div>
<#--        ${msg("mobileNumber")}-->
      <div>
        <div id="mobileError" class="alert alert-danger" style="color: red; display: none;"></div>
      </div>










      <div>
        <label for="userImage">Chargez votre image:</label><br/>
        <input type="file" id="userImage" name="userImage" accept="image/*" onchange="uploadImage(this)" required>
        <div id="imageError" style="color: red; display: none;">Veuillez selectionner une image</div>

      </div>
      <input  type="hidden" id="userImageAttribute" name="user.attributes.image" value="">





      <#if passwordRequired??>
        <div>
          <@inputPrimary.kw
            autocomplete="new-password"
            invalid=["password", "password-confirm"]
            message=false
            name="password"
            type="password"
            oninput="validatePassword(this.value)"
          >
            ${msg("password")}
          </@inputPrimary.kw>
          <div id="passwordAlert" style="color: red; display: none;">
            <p>Le mot de passe doit respecter les critères suivants :</p>
            <ul>
              <li id="length">Au moins 8 caractères</li>
              <li id="uppercase">Au moins une lettre majuscule</li>
              <li id="lowercase">Au moins une lettre minuscule</li>
              <li id="special">Au moins un caractère spécial</li>
            </ul>
          </div>

        </div>
        <div>
          <@inputPrimary.kw
            autocomplete="new-password"
            invalid=["password-confirm"]
            name="password-confirm"
            type="password"
          >
            ${msg("passwordConfirm")}
          </@inputPrimary.kw>
          <div id="confirmPasswordAlert" style="color: red; display: none;">
            Les mots de passe ne correspondent pas.
          </div>
        </div>

<#--        <div class="form-group">-->
<#--          <div class="col-sm-2 col-md-2">-->
<#--            <label for="user.attributes.mobile" class="control-label">Mobile number</label>-->
<#--          </div>-->
<#--          <div class="col-sm-10 col-md-10">-->
<#--            <input type="text" class="form-control" id="user.attributes.mobile" name="user.attributes.mobile" value="${(register.formData['user.attributes.mobile']!'')}"/>-->
<#--          </div>-->
<#--        </div>-->





      </#if>

      <div class="form-group mb-3">
        <label class="font-xssss fw-600 text-grey-500">Select your interests:</label>
        <br/>
        <div class="d-flex align-items-center">

        <@checkboxPrimary.kw
          name="user.attributes.interests"
          id="interests_sport"
          value="sport"

          >
            Sport
          </@checkboxPrimary.kw>

          <@checkboxPrimary.kw
          name="user.attributes.interests"
          id="interests_music"
          value="music"

          >
            Music
          </@checkboxPrimary.kw>

          <@checkboxPrimary.kw
          name="user.attributes.interests"
          id="interests_development"
          value="development"

          >
            Development
          </@checkboxPrimary.kw>

        </div>
      </div>




      <#if recaptchaRequired??>
        <div>
          <div class="g-recaptcha" data-sitekey="${recaptchaSiteKey}" data-size="compact"></div>
        </div>
      </#if>
      <div>
        <@buttonPrimary.kw type="submit" id="submitButton" disabled="disabled">
          ${msg("doRegister")}
        </@buttonPrimary.kw>
      </div>

    </form>
    <div id="errorContainer" style="display: none; color: red;"></div>

    <script>
      const passwordField = document.getElementById('password');
      const passwordAlert = document.getElementById('passwordAlert');

      const validatePassword = () => {
        const password = passwordField.value;

        const lengthCondition = password.length >= 8;
        const uppercaseCondition = /[A-Z]/.test(password);
        const lowercaseCondition = /[a-z]/.test(password);
        const specialCondition = /[!@#$%^&*()_+]/.test(password);

        document.getElementById('length').style.color = lengthCondition ? 'green' : 'red';
        document.getElementById('uppercase').style.color = uppercaseCondition ? 'green' : 'red';
        document.getElementById('lowercase').style.color = lowercaseCondition ? 'green' : 'red';
        document.getElementById('special').style.color = specialCondition ? 'green' : 'red';



        const isPasswordValid = lengthCondition && uppercaseCondition && lowercaseCondition && specialCondition;

        passwordAlert.style.display = isPasswordValid ? 'none' : 'block';

        return isPasswordValid;
      };

      passwordField.addEventListener('input', validatePassword);

      document.addEventListener('DOMContentLoaded', function() {

        const confirmPasswordField = document.getElementById('password-confirm');
        const passwordAlert = document.getElementById('passwordAlert');
        const confirmPasswordAlert = document.getElementById('confirmPasswordAlert');



        const validateConfirmPassword = () => {
          const password = passwordField.value;
          const confirmPassword = confirmPasswordField.value;

          if (password !== confirmPassword) {
            confirmPasswordAlert.style.display = 'block';
            return false;
          } else {
            confirmPasswordAlert.style.display = 'none';
            return true;
          }
        };


        confirmPasswordField.addEventListener('input', validateConfirmPassword);
      });
      document.addEventListener('DOMContentLoaded', function() {
        const emailField = document.querySelector('input[name="email"]');
        const errorContainer = document.querySelector('#emailError');

        emailField.addEventListener('change', async function() {
          const email = emailField.value;

          try {
            // Envoi de la requête POST au serveur pour vérifier l'unicité de l'email
            const response = await fetch('http://localhost:3000/api/user/verifUnicEmail', {
              method: 'POST',
              headers: {
                'Content-Type': 'application/json'
              },
              body: JSON.stringify({ email }) // Formatage des données à envoyer
            });

            // Vérification de la réponse du serveur
            if (response.status === 400) {
              // Si la réponse est une erreur 400 (Bad Request), afficher un message d'erreur
              errorContainer.textContent = 'L\'email est déjà utilisé. Veuillez en choisir un autre.';
              errorContainer.style.display = 'block';
            } else if (!response.ok) {
              // Si la réponse est une erreur autre que 400, afficher une erreur générique
              throw new Error('Network response was not ok');
            } else {
              // Si la réponse est OK, effacer le message d'erreur
              errorContainer.textContent = '';
              errorContainer.style.display = 'none';
            }
          } catch (error) {
            // Gestion des erreurs de requête
            console.error('There was a problem with the fetch operation:', error);
          }
        });
      });

      document.addEventListener('DOMContentLoaded', function() {
        const countryCodeSelect = document.getElementById('countryCode');
        const phoneNumberInput = document.getElementById('phoneNumber');
        const mobileError = document.getElementById('mobileError');

        // Écouter les changements dans le code de pays et le numéro de téléphone
        countryCodeSelect.addEventListener('change', validatePhoneNumber);
        phoneNumberInput.addEventListener('input', validatePhoneNumber);

        // Valider le numéro de téléphone
        async function validatePhoneNumber() {
          const countryCode = countryCodeSelect.value;
          let phoneNumber = phoneNumberInput.value.trim();

          // Supprimer les caractères non numériques
          phoneNumber = phoneNumber.replace(/\D/g, "");

          // Déterminer la longueur requise en fonction du code de pays sélectionné
          let requiredLength = countryCode === "+216" ? 8 : 9;

          // Vérifier si le numéro de téléphone a la longueur requise
          if (phoneNumber.length !== requiredLength) {
            mobileError.textContent = `Le numéro de téléphone doit avoir exactement` +requiredLength+ ` chiffres.`;
            mobileError.style.display = 'block';
            return;
          }

          // Combiner le code de pays et le numéro de téléphone pour former le numéro complet
          const fullPhoneNumber = countryCode + phoneNumber;

          // Assigner la valeur de fullPhoneNumber à l'attribut value de l'input
          phoneNumberInput.value = fullPhoneNumber;

          // Effectuer une requête AJAX pour vérifier l'unicité du numéro de téléphone
          try {
            const response = await fetch('http://localhost:3000/api/user/verifUnicMobile', {
              method: 'POST',
              headers: {
                'Content-Type': 'application/json'
              },
              body: JSON.stringify({ mobile: fullPhoneNumber }) // Envoyer le numéro complet
            });

            if (response.status === 400) {
              mobileError.textContent = 'Le numéro de téléphone est déjà utilisé. Veuillez en choisir un autre.';
              mobileError.style.display = 'block';
            } else if (!response.ok) {
              throw new Error('Network response was not ok');
            } else {
              mobileError.textContent = '';
              mobileError.style.display = 'none';
            }
          } catch (error) {
            console.error('There was a problem with the fetch operation:', error);
          }
        }
      });








      document.addEventListener('DOMContentLoaded', function() {
        const usernameField = document.querySelector('input[name="username"]');
        const usernameError = document.getElementById('usernameError');

        usernameField.addEventListener('input', async function() {
          let username = usernameField.value.trim();

          // Effectuer une requête AJAX pour vérifier l'unicité du nom d'utilisateur
          try {
            const response = await fetch('http://localhost:3000/api/user/verifUnicUsername', {
              method: 'POST',
              headers: {
                'Content-Type': 'application/json'
              },
              body: JSON.stringify({ username })
            });

            const data = await response.json();

            // Vérifier la réponse et afficher le message d'erreur approprié
            if (response.status === 400) {
              // Si la réponse est une erreur 400 (Bad Request), afficher un message d'erreur
              usernameError.textContent = 'Le nom d\'utilisateur est déjà utilisé. Veuillez en choisir un autre.';
              usernameError.style.display = 'block';
            } else if (!response.ok) {
              // Si la réponse est une erreur autre que 400, afficher une erreur générique
              throw new Error('Network response was not ok');
            } else {
              // Si la réponse est OK, effacer le message d'erreur
              usernameError.textContent = '';
              usernameError.style.display = 'none';
            }
          } catch (error) {
            usernameError.textContent = error.message; // Afficher le message d'erreur retourné par l'API
          }
        });
      });
      function uploadImage(input) {
        const imageError = document.getElementById('imageError');
        // Vérifier si un fichier a été sélectionné
        if (input.files.length === 0) {
          // Afficher une alerte pour informer l'utilisateur que l'image est obligatoire
          imageError.style.display = 'block';          return; // Arrêter le processus d'envoi
        }
        imageError.style.display = 'none';
        const formData = new FormData();
        formData.append('image', input.files[0]);

        fetch('http://localhost:3000/api/user/uplaodImage', {
          method: 'POST',
          body: formData
        })
                .then(response => response.json())
                .then(data => {
                  const imageUrl = data.imageUrl;
                  // Mettre à jour la valeur de l'attribut image dans le formulaire Keycloak
                  document.getElementById('userImageAttribute').value = imageUrl;
                })
                .catch(error => console.error('Error uploading image:', error));
      }


      document.addEventListener('DOMContentLoaded', function() {
        const submitButton = document.getElementById('submitButton');

        function validateForm() {
          const formFields = document.querySelectorAll('input[type="text"], input[type="email"], input[type="password"], input[type="tel"]');
          let isValid = true;

          formFields.forEach(field => {
            // Votre logique de validation pour chaque champ du formulaire ici
            // Par exemple, vérifiez si le champ est vide ou s'il contient des caractères invalides
            // Si le champ est invalide, définissez isValid sur false
            if (!field.value.trim()) {
              isValid = false;
            }
          });

          // Vérifier si les champs de mot de passe correspondent
          const passwordField = document.getElementById('password');
          const confirmPasswordField = document.getElementById('password-confirm');
          if (passwordField.value !== confirmPasswordField.value) {
            isValid = false;
          }

          // Activer ou désactiver le bouton de soumission en fonction de l'état de validation
          submitButton.disabled = !isValid;
        }

        // Ajouter des écouteurs d'événements pour chaque champ du formulaire pour valider le formulaire à chaque saisie
        const formFields = document.querySelectorAll('input[type="text"], input[type="email"], input[type="password"], input[type="tel"]');
        formFields.forEach(field => {
          field.addEventListener('input', validateForm);
        });
      });

    </script>
  <#elseif section="nav">
    <@linkSecondary.kw href=url.loginUrl>
      <span class="text-sm">${kcSanitize(msg("backToLogin"))?no_esc}</span>
    </@linkSecondary.kw>
  </#if>
</@layout.registrationLayout>

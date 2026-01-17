{
  home-manager.users.ben = {
    accounts = {
      email.accounts = {
        "1 personal" = {
          primary = true;
          thunderbird.enable = true;
          address = "ben@matthsch.de";
          userName = "ben@matthsch.de";
          realName = "Ben Matthies";
          gpg = {
            key = "C32CE25A032EB2AF";
            encryptByDefault = true;
            signByDefault = true;
          };

          smtp = {
            host = "mail.your-server.de";
            port = 465;
          };
          imap = {
            host = "mail.your-server.de";
            port = 993;
          };

          signature = {
            showSignature = "append";
            text = ''
              Ben Matthies
              Physikstudent, Webentwickler, Läufer, Open-Source-Enthusiast

              GitHub @Wunst
              Web www.matthsch.de
                o
              \_~\
               T|T

              PGP www.matthsch.de/pgp/ben
              C3F1 9D1E 74B5 B8CD 7DD9 34FD C32C E25A 032E B2AF
            '';
          };
        };

        "2 school" = {
          thunderbird.enable = true;
          address = "ben.matthies@mps-ki.de";
          userName = "ben.matthies";
          realName = "Ben Matthies";
          smtp = {
            host = "mps-ki.de";
            port = 465;
          };
          imap = {
            host = "mps-ki.de";
            port = 993;
          };
          signature = {
            showSignature = "append";
            text = ''
              Ben Matthies
              Admin AG
              Max-Planck-Schule Kiel
              Winterbeker Weg 1, 24114 Kiel
            '';
          };
        };

        "3 uni" = {
          thunderbird.enable = true;
          address = "ben.matthies@stu.uni-kiel.de";
          realName = "Ben Matthies";
          userName = "stu249890";
          gpg = {
            key = "C32CE25A032EB2AF";
            encryptByDefault = true;
            signByDefault = true;
          };
          smtp = {
            host = "smtps.mail.uni-kiel.de";
            port = 465;
          };
          imap = {
            host = "imap.mail.uni-kiel.de";
            port = 993;
          };
          signature = {
            showSignature = "append";
            text = ''
              Ben Matthies
              Student der Physik (1Ba)
              3. Fachsemester
              Tutorien für die Physik I und II (UB)
            '';
          };
        };

        "4 webmaster" = {
          thunderbird.enable = true;
          address = "webmaster@matthsch.de";
          userName = "webmaster@matthsch.de";
          realName = "Webmaster";
          gpg = {
            key = "C32CE25A032EB2AF";
            encryptByDefault = true;
            signByDefault = true;
          };
          smtp = {
            host = "mail.your-server.de";
            port = 465;
          };
          imap = {
            host = "mail.your-server.de";
            port = 993;
          };
        };
      };

      calendar.accounts = {
        "1 personal" = {
          primary = true;
          thunderbird.enable = true;
          remote = {
            type = "caldav";
            url = "https://webmail.your-server.de/rpc/calendars/ben@matthsch.de/calendar~VhZ4s7KVMpZA_pYAsglCIMG/";
            userName = "ben@matthsch.de";
          };
        };

        "2 tasks" = {
          thunderbird.enable = true;
          remote = {
            type = "caldav";
            url = "https://webmail.your-server.de/rpc/calendars/ben@matthsch.de/tasks~yEfMegBoUJQmutECCEV2L4j/";
            userName = "ben@matthsch.de";
          };
        };
      };

      contact.accounts."1 personal" = {
        thunderbird.enable = true;
        remote = {
          type = "carddav";
          url = "https://webmail.your-server.de/rpc/addressbooks/ben@matthsch.de/contacts~p8B7toNbt5p5nPUAiL3NP-E/";
          userName = "ben@matthsch.de";
        };
      };
    };
  };
}

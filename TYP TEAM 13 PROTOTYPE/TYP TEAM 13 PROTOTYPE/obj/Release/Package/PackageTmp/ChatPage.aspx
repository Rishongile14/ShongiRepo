<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ChatPage.aspx.cs" Inherits="TYP_TEAM_13_PROTOTYPE.ChatPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <style>
        /* Custom CSS */
        .chat-container {
            width: 100%;
            margin: 50px auto;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 20px;
            background-color:black;
        }

        .message {
            margin-bottom: 15px;
            border-radius:10px;
        }

        .message .sender {
            font-weight: bold;
        }

        .message .timestamp {
            font-size: 12px;
            color: #888;
        }

        .own-message {
            background-color: rgb(15 65 38);
            color:white;
        }

        .other-message {
            background-color: #F0F0F0;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    

<section id="service" class="service">
        <div class="container">
            <div class="service-content">
    <div class="chat-container">
        <div class="message other-message text-center text-primary">
            <p class="sender">Jabulani</p>
            <p>Hello Lethabo! I'm outside.</p>
            <p class="timestamp">10:00 AM</p>
        </div>
        <div class="message own-message text-center" style="color:white">
            <p class="sender">Lethabo</p>
            <p>I'm on my way, thanks for notifying me.</p>
            <p class="timestamp">10:05 AM</p>
        </div>
        <div class="message own-message text-center" style="color:white">
            <p class="sender">Lethabo</p>
            <p>Sorry I'm late and it's rude.</p>
            <p class="timestamp">10:06 AM</p>
        </div>
        <div class="message other-message text-center">
            <p class="sender">Michael</p>
            <p>It's Okay. I'll be waiting.</p>
            <p class="timestamp">10:10 AM</p>
        </div>
        <!-- Typing Div -->
        <div class="typing-div">
            <textarea class="form-control" placeholder="Type your message here..."></textarea>
            <button type="button" class="btn btn-primary btn-sm send-btn" style="padding:15px;margin-top:15px;margin-left:515px;">Send</button>
        </div>
    </div>
</div>
            </div>
<!-- /.container -->
            
        
    </section>
    <!--/.service-->
    <!--service end-->
</asp:Content>

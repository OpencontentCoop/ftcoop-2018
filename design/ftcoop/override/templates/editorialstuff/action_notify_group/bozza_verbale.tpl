{set-block scope=root variable=reply_to}{fetch(user,current_user).email}{/set-block}
{set-block scope=root variable=message_id}{concat('<node.',$post.object.main_node_id,'.editorialstuff_actionnotify','@',ezini("SiteSettings","SiteURL"),'>')}{/set-block}
{set-block scope=root variable=subject}Notifica su {$post.object.name|wash()}{/set-block}
{set-block scope=root variable=content_type}text/html{/set-block}

<h3>Ai componenti del Consiglio di amministrazione e del Collegio sindacale.</h3>

<p>Gentili Signore e Signori,</p>

<p>
  informiamo che, nell'area del sito a voi riservata, è stata pubblicata la bozza del <a href="{$post.editorial_url|ezurl(no,full)}">{$post.object.name|wash()}</a>.
  Cliccando sul testo in blu, potete accedervi direttamente, dopo aver inserito le vostre credenziali.
</p>

<p>Eventuali osservazioni sul contenuto del verbale potranno essere comunicate a: roberta.girardini@ftcoop.it (0461-898.608).</p>
<p>In caso di necessità tecniche, potete contattare:sara.perugini@ftcoop.it (0461-898.614).</p>

<p>Con i più cordiali saluti.</p>

<p><em>Mauro Fezzi</em> - presidente</p>


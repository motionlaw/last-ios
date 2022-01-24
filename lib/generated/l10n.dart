// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Translate {
  Translate();

  static Translate? _current;

  static Translate get current {
    assert(_current != null,
        'No instance of Translate was loaded. Try to initialize the Translate delegate before accessing Translate.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Translate> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Translate();
      Translate._current = instance;

      return instance;
    });
  }

  static Translate of(BuildContext context) {
    final instance = Translate.maybeOf(context);
    assert(instance != null,
        'No instance of Translate present in the widget tree. Did you add Translate.delegate in localizationsDelegates?');
    return instance!;
  }

  static Translate? maybeOf(BuildContext context) {
    return Localizations.of<Translate>(context, Translate);
  }

  /// `-------Estos son los valores para la ventana de login-------`
  String get login_view_translations {
    return Intl.message(
      '-------Estos son los valores para la ventana de login-------',
      name: 'login_view_translations',
      desc: '',
      args: [],
    );
  }

  /// `Correo electrónico`
  String get input_email {
    return Intl.message(
      'Correo electrónico',
      name: 'input_email',
      desc: '',
      args: [],
    );
  }

  /// `Confirmar Correo`
  String get input_confirm_email {
    return Intl.message(
      'Confirmar Correo',
      name: 'input_confirm_email',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña`
  String get input_password {
    return Intl.message(
      'Contraseña',
      name: 'input_password',
      desc: '',
      args: [],
    );
  }

  /// `Nombre Completo`
  String get input_fullname {
    return Intl.message(
      'Nombre Completo',
      name: 'input_fullname',
      desc: '',
      args: [],
    );
  }

  /// `Ingresar`
  String get button_signin {
    return Intl.message(
      'Ingresar',
      name: 'button_signin',
      desc: '',
      args: [],
    );
  }

  /// `Registro`
  String get button_register {
    return Intl.message(
      'Registro',
      name: 'button_register',
      desc: '',
      args: [],
    );
  }

  /// `¿No tienes cuenta?`
  String get label_dont_have_account {
    return Intl.message(
      '¿No tienes cuenta?',
      name: 'label_dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Regresar al inicio`
  String get label_back_sign_in {
    return Intl.message(
      'Regresar al inicio',
      name: 'label_back_sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Términos  de uso & poliza de privacidad`
  String get label_terms_conditions {
    return Intl.message(
      'Términos  de uso & poliza de privacidad',
      name: 'label_terms_conditions',
      desc: '',
      args: [],
    );
  }

  /// `-------Estos son los valores para el menu--------`
  String get menu_options_translations {
    return Intl.message(
      '-------Estos son los valores para el menu--------',
      name: 'menu_options_translations',
      desc: '',
      args: [],
    );
  }

  /// `Información del Caso`
  String get case_information {
    return Intl.message(
      'Información del Caso',
      name: 'case_information',
      desc: '',
      args: [],
    );
  }

  /// `Mis casos`
  String get you_cases {
    return Intl.message(
      'Mis casos',
      name: 'you_cases',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message(
      'Chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `Realizar Pago`
  String get make_payment {
    return Intl.message(
      'Realizar Pago',
      name: 'make_payment',
      desc: '',
      args: [],
    );
  }

  /// `Contáctanos`
  String get contact_us {
    return Intl.message(
      'Contáctanos',
      name: 'contact_us',
      desc: '',
      args: [],
    );
  }

  /// `Referir un Amigo`
  String get refer_friend {
    return Intl.message(
      'Referir un Amigo',
      name: 'refer_friend',
      desc: '',
      args: [],
    );
  }

  /// `Dejar Comentario`
  String get leave_review {
    return Intl.message(
      'Dejar Comentario',
      name: 'leave_review',
      desc: '',
      args: [],
    );
  }

  /// `Blog`
  String get blog {
    return Intl.message(
      'Blog',
      name: 'blog',
      desc: '',
      args: [],
    );
  }

  /// `Configuraciones`
  String get settings {
    return Intl.message(
      'Configuraciones',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Cerrar Sesión`
  String get logout {
    return Intl.message(
      'Cerrar Sesión',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `--------Estos son los valores para las demas ventanas-------`
  String get home_view_translations {
    return Intl.message(
      '--------Estos son los valores para las demas ventanas-------',
      name: 'home_view_translations',
      desc: '',
      args: [],
    );
  }

  /// `Asignación de Caso`
  String get assign_case {
    return Intl.message(
      'Asignación de Caso',
      name: 'assign_case',
      desc: '',
      args: [],
    );
  }

  /// `Esperando Presentación`
  String get waiting_introduction {
    return Intl.message(
      'Esperando Presentación',
      name: 'waiting_introduction',
      desc: '',
      args: [],
    );
  }

  /// `Recolectando Evidencia`
  String get collecting_evidence {
    return Intl.message(
      'Recolectando Evidencia',
      name: 'collecting_evidence',
      desc: '',
      args: [],
    );
  }

  /// `Preparando Paquete`
  String get preparing_packet {
    return Intl.message(
      'Preparando Paquete',
      name: 'preparing_packet',
      desc: '',
      args: [],
    );
  }

  /// `En revision de Abogado`
  String get attorney_review {
    return Intl.message(
      'En revision de Abogado',
      name: 'attorney_review',
      desc: '',
      args: [],
    );
  }

  /// `Revision y firmas`
  String get review_and_signatures {
    return Intl.message(
      'Revision y firmas',
      name: 'review_and_signatures',
      desc: '',
      args: [],
    );
  }

  /// `Radicado`
  String get filed {
    return Intl.message(
      'Radicado',
      name: 'filed',
      desc: '',
      args: [],
    );
  }

  /// `Pendiente`
  String get pending {
    return Intl.message(
      'Pendiente',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `En Espera`
  String get on_hold {
    return Intl.message(
      'En Espera',
      name: 'on_hold',
      desc: '',
      args: [],
    );
  }

  /// `Pendiente de Pago`
  String get pending_payment {
    return Intl.message(
      'Pendiente de Pago',
      name: 'pending_payment',
      desc: '',
      args: [],
    );
  }

  /// `Próximo a Audiencia`
  String get upcoming_hearing {
    return Intl.message(
      'Próximo a Audiencia',
      name: 'upcoming_hearing',
      desc: '',
      args: [],
    );
  }

  /// `Próximo a Juicio`
  String get upcoming_trial {
    return Intl.message(
      'Próximo a Juicio',
      name: 'upcoming_trial',
      desc: '',
      args: [],
    );
  }

  /// `Detalle del Caso`
  String get button_case_detail {
    return Intl.message(
      'Detalle del Caso',
      name: 'button_case_detail',
      desc: '',
      args: [],
    );
  }

  /// `Últimas Noticias`
  String get label_latest_news {
    return Intl.message(
      'Últimas Noticias',
      name: 'label_latest_news',
      desc: '',
      args: [],
    );
  }

  /// `Leer Más`
  String get label_read_more {
    return Intl.message(
      'Leer Más',
      name: 'label_read_more',
      desc: '',
      args: [],
    );
  }

  /// `-------Estos son los valores para las demas vistas------`
  String get content_view_translations {
    return Intl.message(
      '-------Estos son los valores para las demas vistas------',
      name: 'content_view_translations',
      desc: '',
      args: [],
    );
  }

  /// `Tipo de Caso`
  String get practice_area {
    return Intl.message(
      'Tipo de Caso',
      name: 'practice_area',
      desc: '',
      args: [],
    );
  }

  /// `Fecha de creación`
  String get added {
    return Intl.message(
      'Fecha de creación',
      name: 'added',
      desc: '',
      args: [],
    );
  }

  /// `Agregar Actualización`
  String get add_new_update {
    return Intl.message(
      'Agregar Actualización',
      name: 'add_new_update',
      desc: '',
      args: [],
    );
  }

  /// `Actualización del Caso`
  String get case_update {
    return Intl.message(
      'Actualización del Caso',
      name: 'case_update',
      desc: '',
      args: [],
    );
  }

  /// `Calendario`
  String get calendar {
    return Intl.message(
      'Calendario',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  /// `Fecha`
  String get date {
    return Intl.message(
      'Fecha',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Hora`
  String get time {
    return Intl.message(
      'Hora',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Título`
  String get title {
    return Intl.message(
      'Título',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Cerrar`
  String get close {
    return Intl.message(
      'Cerrar',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Información de Facturación`
  String get case_billing_information {
    return Intl.message(
      'Información de Facturación',
      name: 'case_billing_information',
      desc: '',
      args: [],
    );
  }

  /// `Selecciona una Factura para Pago`
  String get select_invoice {
    return Intl.message(
      'Selecciona una Factura para Pago',
      name: 'select_invoice',
      desc: '',
      args: [],
    );
  }

  /// `No hay Facturas Disponibles`
  String get no_available_billings {
    return Intl.message(
      'No hay Facturas Disponibles',
      name: 'no_available_billings',
      desc: '',
      args: [],
    );
  }

  /// `Documentos`
  String get documents {
    return Intl.message(
      'Documentos',
      name: 'documents',
      desc: '',
      args: [],
    );
  }

  /// `Nombre`
  String get name {
    return Intl.message(
      'Nombre',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Acción`
  String get action {
    return Intl.message(
      'Acción',
      name: 'action',
      desc: '',
      args: [],
    );
  }

  /// `Esta carpeta se encuentra vacía`
  String get folder_empty {
    return Intl.message(
      'Esta carpeta se encuentra vacía',
      name: 'folder_empty',
      desc: '',
      args: [],
    );
  }

  /// `Ingresa en MyCase para ver la lista completa de\nDocumentos`
  String get login_mycase {
    return Intl.message(
      'Ingresa en MyCase para ver la lista completa de\nDocumentos',
      name: 'login_mycase',
      desc: '',
      args: [],
    );
  }

  /// `Presiona aqui para Subir`
  String get upload_document_button {
    return Intl.message(
      'Presiona aqui para Subir',
      name: 'upload_document_button',
      desc: '',
      args: [],
    );
  }

  /// `Atrás`
  String get back {
    return Intl.message(
      'Atrás',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Completa el formulario, una vez enviado nuestro equipo se pondra en contacto a la brevedad`
  String get contact_us_header {
    return Intl.message(
      'Completa el formulario, una vez enviado nuestro equipo se pondra en contacto a la brevedad',
      name: 'contact_us_header',
      desc: '',
      args: [],
    );
  }

  /// `Miembro del Equipo`
  String get input_staff_member {
    return Intl.message(
      'Miembro del Equipo',
      name: 'input_staff_member',
      desc: '',
      args: [],
    );
  }

  /// `Tema`
  String get input_subject {
    return Intl.message(
      'Tema',
      name: 'input_subject',
      desc: '',
      args: [],
    );
  }

  /// `Mensaje`
  String get input_message {
    return Intl.message(
      'Mensaje',
      name: 'input_message',
      desc: '',
      args: [],
    );
  }

  /// `Enviar`
  String get button_submit {
    return Intl.message(
      'Enviar',
      name: 'button_submit',
      desc: '',
      args: [],
    );
  }

  /// `Escribe el nombre completo, la direccion de correo o el número telefónico de la persona que quieres invitar`
  String get refer_friend_header {
    return Intl.message(
      'Escribe el nombre completo, la direccion de correo o el número telefónico de la persona que quieres invitar',
      name: 'refer_friend_header',
      desc: '',
      args: [],
    );
  }

  /// `te ha invitado a Motion Law, un miembro del equipo se pondrá en contacto contigo a la brevedad, responde a este email para agendar tu consulta inicial sin costo o comunicate ahora al (202-918-1799)`
  String get refered_message {
    return Intl.message(
      'te ha invitado a Motion Law, un miembro del equipo se pondrá en contacto contigo a la brevedad, responde a este email para agendar tu consulta inicial sin costo o comunicate ahora al (202-918-1799)',
      name: 'refered_message',
      desc: '',
      args: [],
    );
  }

  /// `-------Estos son los valores para la vista de configuraciones-------`
  String get settings_fields_translations {
    return Intl.message(
      '-------Estos son los valores para la vista de configuraciones-------',
      name: 'settings_fields_translations',
      desc: '',
      args: [],
    );
  }

  /// `Nombres`
  String get input_first_name {
    return Intl.message(
      'Nombres',
      name: 'input_first_name',
      desc: '',
      args: [],
    );
  }

  /// `Apellidos`
  String get input_lastname {
    return Intl.message(
      'Apellidos',
      name: 'input_lastname',
      desc: '',
      args: [],
    );
  }

  /// `Número de Identificación`
  String get input_id_number {
    return Intl.message(
      'Número de Identificación',
      name: 'input_id_number',
      desc: '',
      args: [],
    );
  }

  /// `Número de Teléfono`
  String get input_phone_number {
    return Intl.message(
      'Número de Teléfono',
      name: 'input_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Fecha de Cumpleaños`
  String get input_birthday {
    return Intl.message(
      'Fecha de Cumpleaños',
      name: 'input_birthday',
      desc: '',
      args: [],
    );
  }

  /// `Información Personal`
  String get label_profile_information {
    return Intl.message(
      'Información Personal',
      name: 'label_profile_information',
      desc: '',
      args: [],
    );
  }

  /// `Centro de Notificaciones`
  String get label_notification_center {
    return Intl.message(
      'Centro de Notificaciones',
      name: 'label_notification_center',
      desc: '',
      args: [],
    );
  }

  /// `Notificaciones Push`
  String get push_notification {
    return Intl.message(
      'Notificaciones Push',
      name: 'push_notification',
      desc: '',
      args: [],
    );
  }

  /// `Habilitar notificaciones push en tu dispositivo`
  String get advertise_push_notification {
    return Intl.message(
      'Habilitar notificaciones push en tu dispositivo',
      name: 'advertise_push_notification',
      desc: '',
      args: [],
    );
  }

  /// `Guardar`
  String get button_save {
    return Intl.message(
      'Guardar',
      name: 'button_save',
      desc: '',
      args: [],
    );
  }

  /// `Cargando`
  String get loading {
    return Intl.message(
      'Cargando',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Número`
  String get number {
    return Intl.message(
      'Número',
      name: 'number',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Estado`
  String get status {
    return Intl.message(
      'Estado',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Indica por lo menos un correo o número de teléfono`
  String get provide_at_least {
    return Intl.message(
      'Indica por lo menos un correo o número de teléfono',
      name: 'provide_at_least',
      desc: '',
      args: [],
    );
  }

  /// `A continuación se muestra el mensaje que recibirá tu referido una vez presiones el botón Enviar`
  String get below_is_the_message {
    return Intl.message(
      'A continuación se muestra el mensaje que recibirá tu referido una vez presiones el botón Enviar',
      name: 'below_is_the_message',
      desc: '',
      args: [],
    );
  }

  /// `-------Traduccion de mensajes informativos-------`
  String get messages_translations {
    return Intl.message(
      '-------Traduccion de mensajes informativos-------',
      name: 'messages_translations',
      desc: '',
      args: [],
    );
  }

  /// `Debes diligenciar los campos antes de continuar`
  String get validation_submit {
    return Intl.message(
      'Debes diligenciar los campos antes de continuar',
      name: 'validation_submit',
      desc: '',
      args: [],
    );
  }

  /// `Nuestro equipo se pondra en contacto a la brevedad`
  String get sent_succesfully {
    return Intl.message(
      'Nuestro equipo se pondra en contacto a la brevedad',
      name: 'sent_succesfully',
      desc: '',
      args: [],
    );
  }

  /// `Mensaje enviado con exito`
  String get sent_succesfully_title {
    return Intl.message(
      'Mensaje enviado con exito',
      name: 'sent_succesfully_title',
      desc: '',
      args: [],
    );
  }

  /// `Campos Requeridos`
  String get required_fields {
    return Intl.message(
      'Campos Requeridos',
      name: 'required_fields',
      desc: '',
      args: [],
    );
  }

  /// `No hay casos asociados a tu cuenta`
  String get no_cases {
    return Intl.message(
      'No hay casos asociados a tu cuenta',
      name: 'no_cases',
      desc: '',
      args: [],
    );
  }

  /// `Escribe una nueva actualización para este caso`
  String get message_update_modal {
    return Intl.message(
      'Escribe una nueva actualización para este caso',
      name: 'message_update_modal',
      desc: '',
      args: [],
    );
  }

  /// `Archivo subido con exito`
  String get file_upload {
    return Intl.message(
      'Archivo subido con exito',
      name: 'file_upload',
      desc: '',
      args: [],
    );
  }

  /// `Datos Inválidos`
  String get incorrect_username {
    return Intl.message(
      'Datos Inválidos',
      name: 'incorrect_username',
      desc: '',
      args: [],
    );
  }

  /// `Datos Inválidos`
  String get wrong_data {
    return Intl.message(
      'Datos Inválidos',
      name: 'wrong_data',
      desc: '',
      args: [],
    );
  }

  /// `Completa la información`
  String get incomplete_information {
    return Intl.message(
      'Completa la información',
      name: 'incomplete_information',
      desc: '',
      args: [],
    );
  }

  /// `El email ingresado esta incorrecto`
  String get email_match {
    return Intl.message(
      'El email ingresado esta incorrecto',
      name: 'email_match',
      desc: '',
      args: [],
    );
  }

  /// `El usuario ya fue creado`
  String get user_already_created {
    return Intl.message(
      'El usuario ya fue creado',
      name: 'user_already_created',
      desc: '',
      args: [],
    );
  }

  /// `Un correo de confirmación fue enviado a tu email, revisa las instrucciones para activar tu cuenta.`
  String get registered_msg {
    return Intl.message(
      'Un correo de confirmación fue enviado a tu email, revisa las instrucciones para activar tu cuenta.',
      name: 'registered_msg',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Translate> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Translate> load(Locale locale) => Translate.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

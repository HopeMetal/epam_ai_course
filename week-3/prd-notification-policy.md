# PRD — Notification Policy Engine

**Author**: Product · **Status**: Ready for development · **Version**: 1.0
**Supersedes**: *Customer Notification Service — Requirements v0.3* (the document from Week 1, after two clarification rounds). This PRD covers the **decision engine only**; delivery is a separate component.

## Background

Customers get order updates by email, SMS and push. Today every producing service decides for itself what to send, when, and where. Support cannot explain to a customer why a message arrived at 02:00, Finance cannot explain the SMS bill, and Legal has asked twice about quiet-hours regulation. We want one component, the **Notification Policy Engine**, that takes an event plus a customer profile and returns a single, explainable decision: send now, hold, or drop, on which channel, and whether it may be batched with others.

## Goals

- One decision per event, with human-readable reasons.
- Customer preferences and quiet hours are always respected.
- SMS spend goes down without customers missing anything important.

## Non-goals

- Sending messages (the dispatcher does that).
- Message templates and localization.
- The in-app notification centre (phase 2).

## Functional requirements

**FR-1 Interface.** Input is an *event* `{type, order_id, occurred_at, importance}` and a *customer* `{id, preferred_channel, opted_out, marketing_consent, timezone, locale}`. Output is a *decision* `{action: send | hold | drop, channel, hold_until, batch_key, reasons[]}`.

**FR-2 Preferred channel.** The customer's preferred channel is used unless a rule below overrides it.

**FR-3 SMS discipline.** SMS is used only for important notifications. A notification that would have gone by SMS but is not important goes by email instead.

**FR-4 Opt-out.** Customers who have opted out receive no notifications. Transactional notifications are always sent regardless of preferences.

**FR-5 Quiet hours.** Between 22:00 and 07:00, non-urgent notifications are held until 07:00.

**FR-6 Batching.** When several events for the same order occur within a short window, they are combined into one message. The engine assigns a `batch_key` so the dispatcher can group them.

**FR-7 Marketing cap.** Marketing notifications require marketing consent and are sent at most once per customer per week.

**FR-8 Email-only accounts.** Customers belonging to an email-only enterprise account never receive push notifications.

**FR-9 Explainability.** Every decision carries at least one reason that names the rule applied (for example `quiet_hours`, `sms_not_important`).

**FR-10 Unknown events.** Unknown event types should be handled gracefully.

## Non-functional requirements

**NFR-1 Pure.** The engine performs no I/O and reads no clock; the current time is an input. Same inputs, same decision.

**NFR-2 Fast.** A decision takes under 5 ms.

**NFR-3 Portable.** Python 3.11 or newer, standard library only.

## Acceptance examples

1. *Order shipped* at 23:30 customer local time, preferred channel push, importance normal → **hold** until 07:00, channel push, reason `quiet_hours`.
2. *Payment failed* at 23:30, preferred channel SMS, importance critical → **send** now by SMS.
3. *Promo: weekend sale*, customer without marketing consent → **drop**, reason `no_marketing_consent`.
4. *Order shipped* then *Out for delivery* two minutes apart, same order → both decisions carry the same `batch_key`.

## Notes from the stakeholder meeting

- Legal: in some markets SMS quiet hours are regulated and **cannot** be bypassed, not even for important messages.
- Support wants an "explain this decision" view — FR-9 covers it.
- One enterprise client insists their users never get push, only email. That is where FR-8 comes from.
- The `importance` field is set by the producing service. Values seen in production so far: `low`, `normal`, `high`, `critical`.
- Finance asked whether batching also applies to SMS.

## Open questions

None — this PRD is ready for development.

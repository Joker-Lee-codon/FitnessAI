const screens = [...document.querySelectorAll('[data-screen]')];
const tabs = [...document.querySelectorAll('[data-nav]')];
const tabBar = document.querySelector('.tab-bar');
const phone = document.querySelector('.phone');
const historyStack = ['today'];

function showScreen(name, { push = true } = {}) {
  const target = screens.find((screen) => screen.dataset.screen === name);
  if (!target) return;

  screens.forEach((screen) => screen.classList.toggle('is-active', screen === target));
  const isPrimary = ['today', 'history', 'analysis'].includes(name);
  tabBar.hidden = !isPrimary;
  phone.classList.toggle('detail-mode', !isPrimary);

  document.querySelectorAll('.tab-bar [data-nav]').forEach((button) => {
    button.classList.toggle('is-selected', button.dataset.nav === name);
  });

  if (push && historyStack.at(-1) !== name) historyStack.push(name);
  target.scrollTop = 0;
  requestAnimationFrame(() => target.querySelector('h1')?.focus?.({ preventScroll: true }));
}

document.addEventListener('click', (event) => {
  const nav = event.target.closest('[data-nav]');
  if (nav) {
    historyStack.length = 0;
    historyStack.push(nav.dataset.nav);
    showScreen(nav.dataset.nav, { push: false });
    return;
  }

  const opener = event.target.closest('[data-open]');
  if (opener) {
    const destination = opener.dataset.open === 'review-complete' ? 'review' : opener.dataset.open;
    showScreen(destination);
    return;
  }

  const back = event.target.closest('[data-back]');
  if (back) {
    historyStack.pop();
    showScreen(historyStack.at(-1) || 'today', { push: false });
  }
});

const loadButtons = [...document.querySelectorAll('[data-load]')];
const loadValue = document.querySelector('#load-value');
const loadState = document.querySelector('#load-state');
const unresolvedSet = document.querySelector('#unresolved-set');
const saveReview = document.querySelector('#save-review');
const reviewStatus = document.querySelector('.review-status');

loadButtons.forEach((button) => {
  button.addEventListener('click', () => {
    loadButtons.forEach((candidate) => candidate.classList.remove('is-selected'));
    button.classList.add('is-selected');
    const value = button.dataset.load === 'other' ? '自定' : button.dataset.load;
    loadValue.textContent = value;
    loadState.textContent = '待保存';
    unresolvedSet.classList.remove('unresolved');
    saveReview.disabled = false;
    saveReview.textContent = '保存复核';
    document.querySelector('#save-note').textContent = '保存后先写入本机，再等待同步';
  });
});

saveReview.addEventListener('click', () => {
  saveReview.disabled = true;
  saveReview.textContent = '已保存到本机';
  loadState.textContent = '用户补充';
  unresolvedSet.querySelector('.set-tick').className = 'set-tick confirmed-tick';
  document.querySelector('#load-choices').hidden = true;
  reviewStatus.classList.remove('pending');
  reviewStatus.classList.add('resolved');
  reviewStatus.innerHTML = '<span>训练记录已完整</span><p>本地保存成功；同步会在网络可用时继续。</p>';
  document.querySelector('#save-note').textContent = '等待同步不会影响这次本地保存';
});

document.querySelector('#start-watch').addEventListener('click', (event) => {
  event.currentTarget.textContent = '已发送到 Apple Watch';
  event.currentTarget.disabled = true;
  document.querySelector('#watch-note').textContent = '请在 Apple Watch 上开始或继续训练';
});
